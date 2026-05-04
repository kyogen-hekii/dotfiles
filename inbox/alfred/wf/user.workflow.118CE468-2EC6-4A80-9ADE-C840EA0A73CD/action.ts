const query = Deno.args[0] || '';

const process = new Deno.Command('open', {
  args: [query],
});
await process.output();
