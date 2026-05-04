// @ts-ignore forceConsistentCasingInFileNames
import denoalfy, { AlfredItem } from '../utils/denoalfy.ts';
import * as clippy from "https://deno.land/x/clippy/mod.ts";

const createPath = (repoName: string, fromRootPath: string) => `https://github.com/xxx-dev/${repoName}/blob/develop/` + fromRootPath;
const defaultArg = 'b';
const repoNameArg = Deno.args[0] || defaultArg;
const repoNameMap: Record<string, string> = {
  b: 'backend',
  backend: 'backend',
  f: 'frontend',
  frontend: 'frontend',
  tdnw: 'backend-tdnw_report'
}
const repoName = repoNameMap[repoNameArg] || repoNameMap[defaultArg]

// 開いているworkspaceによってpathが変わってしまう
// backend-object_data_cleaner/src/commands/delete-s3-objects.ts
// backend/rest-api/src/application/ai-analysis/ai-analysis.service.ts
// rest-api/src/application/ai-analysis/ai-analysis.service.ts
const txt = await clippy.readText();
const regExpWithRepoName = new RegExp(`^${repoName}\/`);
const rootPath = txt.replace(regExpWithRepoName, '');
const targetPath = createPath(repoName, rootPath);

denoalfy.output([{ title: 'githubで開く', subtitle: 'backend,frontendを指定して、クリップボードのpathをgithubで開きます。', arg: targetPath }]);

