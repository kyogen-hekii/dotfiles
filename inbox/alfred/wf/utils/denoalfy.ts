// denoalfy.ts - alfy互換のDenoネイティブモジュール

// 型定義
export interface AlfredItem {
  title: string;
  subtitle?: string;
  arg?: string;
  icon?: {
    path?: string;
    type?: string;
  };
  valid?: boolean;
  match?: string;
  autocomplete?: string;
  type?: string;
  mods?: {
    [key: string]: {
      valid?: boolean;
      arg?: string;
      subtitle?: string;
    };
  };
  text?: {
    copy?: string;
    largetype?: string;
  };
  quicklookurl?: string;
}

// キャッシュ管理クラス
class Cache {
  private cacheDir: string;
  private maxAge: number;

  constructor(id = "denoalfy-cache", { maxAge = 86400000 } = {}) {
    this.cacheDir = `${Deno.env.get("HOME")}/.cache/denoalfy/${id}`;
    this.maxAge = maxAge;
    this.ensureCacheDir();
  }

  private ensureCacheDir() {
    try {
      Deno.mkdirSync(this.cacheDir, { recursive: true });
    } catch (error) {
      if (!(error instanceof Deno.errors.AlreadyExists)) {
        throw error;
      }
    }
  }

  private getFilePath(key: string): string {
    return `${this.cacheDir}/${key}.json`;
  }

  get(key: string): any {
    try {
      const filePath = this.getFilePath(key);
      const fileInfo = Deno.statSync(filePath);
      const now = new Date().getTime();

      if (now - fileInfo.mtime!.getTime() > this.maxAge) {
        return undefined;
      }

      const fileContent = Deno.readTextFileSync(filePath);
      return JSON.parse(fileContent).data;
    } catch (error) {
      return undefined;
    }
  }

  set(key: string, data: any): void {
    const filePath = this.getFilePath(key);
    const fileContent = JSON.stringify({ data });
    Deno.writeTextFileSync(filePath, fileContent);
  }

  clear(): void {
    try {
      for (const entry of Deno.readDirSync(this.cacheDir)) {
        Deno.removeSync(`${this.cacheDir}/${entry.name}`);
      }
    } catch (error) {
      // キャッシュディレクトリが存在しない場合は何もしない
    }
  }
}

// 設定管理クラス
class Config {
  private configPath: string;
  private data: Record<string, any>;

  constructor(id = "denoalfy-config") {
    this.configPath = `${Deno.env.get("HOME")}/.config/denoalfy/${id}.json`;
    this.data = this.loadConfig();
    this.ensureConfigDir();
  }

  private ensureConfigDir() {
    try {
      Deno.mkdirSync(`${Deno.env.get("HOME")}/.config/denoalfy`, {
        recursive: true,
      });
    } catch (error) {
      if (!(error instanceof Deno.errors.AlreadyExists)) {
        throw error;
      }
    }
  }

  private loadConfig(): Record<string, any> {
    try {
      const fileContent = Deno.readTextFileSync(this.configPath);
      return JSON.parse(fileContent);
    } catch (error) {
      return {};
    }
  }

  get(key: string): any {
    return this.data[key];
  }

  set(key: string, value: any): void {
    this.data[key] = value;
    this.save();
  }

  delete(key: string): void {
    delete this.data[key];
    this.save();
  }

  save(): void {
    Deno.writeTextFileSync(this.configPath, JSON.stringify(this.data, null, 2));
  }
}

// フェッチヘルパー
async function fetch(
  url: string,
  options: RequestInit = {}
): Promise<Response> {
  return await globalThis.fetch(url, options);
}

// 主要クラス
export class DenoAlfy {
  cache: Cache;
  config: Config;

  constructor(options: { cache?: { maxAge?: number }; config?: string } = {}) {
    const workflowId = crypto.randomUUID();
    this.cache = new Cache(options.config || workflowId, options.cache);
    this.config = new Config(options.config || workflowId);
  }

  // 結果出力
  output(items: AlfredItem[]): void {
    console.log(JSON.stringify({ items }));
  }

  // 入力アイテムをフィルタリング
  inputMatches(
    input: string,
    items: AlfredItem[],
    returnMatchedItems = true
  ): AlfredItem[] {
    if (!input) {
      return returnMatchedItems ? items : [];
    }

    const inputLower = input.toLowerCase();
    const result = items.filter((item) => {
      const title = (item.title || "").toLowerCase();
      const subtitle = (item.subtitle || "").toLowerCase();
      const match = (item.match || "").toLowerCase();

      return (
        title.includes(inputLower) ||
        subtitle.includes(inputLower) ||
        match.includes(inputLower)
      );
    });

    return returnMatchedItems ? result : [];
  }

  // アルファベット順にソート
  sortAlphabetically(items: AlfredItem[], property = "title"): AlfredItem[] {
    return [...items].sort((a, b) => {
      const aProp = String(a[property as keyof AlfredItem] || "");
      const bProp = String(b[property as keyof AlfredItem] || "");
      return aProp.localeCompare(bProp);
    });
  }

  // 非同期データのキャッシュと処理
  async fetchData(
    url: string,
    key: string,
    options: RequestInit = {}
  ): Promise<any> {
    const cachedData = this.cache.get(key);

    if (cachedData) {
      return cachedData;
    }

    const response = await fetch(url, options);
    const data = await response.json();
    this.cache.set(key, data);
    return data;
  }

  // エラー表示
  error(error: Error | string): void {
    const title = error instanceof Error ? error.message : error;
    const subtitle =
      error instanceof Error ? error.stack : "Press ⌘L to see details";

    this.output([
      {
        title,
        subtitle,
        valid: false,
        text: {
          copy: error instanceof Error ? error.stack : error,
          largetype: error instanceof Error ? error.stack : error,
        },
        icon: {
          path: "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns",
        },
      },
    ]);
  }

  // ワークフローへの入力を取得
  getInput(): string {
    return Deno.args[0] || "";
  }
}

// エクスポート
const denoalfy = new DenoAlfy();
export default denoalfy;
