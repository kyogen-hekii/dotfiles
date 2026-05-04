// @ts-ignore forceConsistentCasingInFileNames
import denoalfy, { AlfredItem } from './denoalfy.ts';

const createResponse = (title: AlfredItem['title'], subtitle: AlfredItem['subtitle'], url: string) => {
  return {
    title,
    subtitle,
    arg: url,
  };
};

const query = Deno.args[0] || '';

if (!query) {
  denoalfy.output([{ title: '', subtitle: '例: react, deno, typescript' }]);
} else {
  denoalfy.output([
    createResponse('Alfredeno', 'A simple Alfred workflow to search for npm packages', 'https://www.npmjs.com/search?q=deno')
  ]);
}