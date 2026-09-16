// Container-owned provider qualification, NOT full FeatureRun/installer proof.
// GitHub is mocked. Only uniquely named disposable containers/volumes are removed.
import assert from 'node:assert/strict';
import { createServer } from 'node:http';
import { createHash, randomBytes, randomUUID } from 'node:crypto';
import { mkdtemp, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { execFileSync } from 'node:child_process';

const image = process.env.LIGHT_GITHUB_ACTION_PROVIDER_IMAGE || 'light-github-action-provider:phase1-local';
const suffix = randomUUID();
const container = `publication-gate-${suffix}`;
const volume = `publication-gate-${suffix}`;
const secrets = `publication-gate-secrets-${suffix}`;
const directory = await mkdtemp(join(tmpdir(), 'publication-provider-gate-'));
const token = randomBytes(32).toString('hex');
await writeFile(join(directory, 'service'), token, { mode: 0o600 });
await writeFile(join(directory, 'github'), 'mock-github-token-no-remote-access', { mode: 0o600 });
const docker = (...args) => execFileSync('docker', args, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'] });
let writes = 0;
let document;
const issues = [];
const comments = [];
const commit = 'a'.repeat(40);
const server = createServer(async (request, response) => {
  const url = new URL(request.url, 'http://localhost');
  const chunks = [];
  for await (const chunk of request) chunks.push(chunk);
  const body = chunks.length ? JSON.parse(Buffer.concat(chunks)) : {};
  const reply = (status, value) => {
    response.writeHead(status, { 'content-type': 'application/json' });
    response.end(JSON.stringify(value));
  };
  if (url.pathname === '/user') return reply(200, { id: 7 });
  if (url.pathname === '/repos/o/r/issues') {
    if (request.method === 'GET') return reply(200, issues);
    writes++;
    issues.push({ id: 11, number: 1, ...body, user: { id: 7 }, html_url: 'https://github.com/o/r/issues/1' });
    return reply(500, { message: 'committed; response lost' });
  }
  if (url.pathname === '/repos/o/r/issues/1/comments') {
    if (request.method === 'GET') return reply(200, comments);
    writes++;
    comments.push({ id: 22, ...body, user: { id: 7 }, html_url: 'https://github.com/o/r/issues/1#issuecomment-22' });
    return reply(500, { message: 'committed; response lost' });
  }
  if (url.pathname === '/repos/o/r/contents/qualification/design.md') {
    if (request.method === 'GET') return reply(document ? 200 : 404, document || {});
    writes++;
    document = { type: 'file', path: 'qualification/design.md', sha: 'b'.repeat(40), content: body.content };
    return reply(500, { message: 'committed; response lost' });
  }
  if (url.pathname === '/repos/o/r/commits') return reply(200, [{ sha: commit }]);
  reply(404, {});
});
await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
const githubPort = server.address().port;
// Reserve a free endpoint before starting the host-networked disposable provider.
const reservation = createServer();
await new Promise(resolve => reservation.listen(0, '127.0.0.1', resolve));
const port = reservation.address().port;
await new Promise(resolve => reservation.close(resolve));
const endpoint = `http://127.0.0.1:${port}/v1/publications`;
const policy = {
  repositories: ['o/r'], documentBranches: ['qualification/publication'],
  documentPaths: ['qualification/design.md'], allowIssues: true, allowComments: true,
};
const start = () => docker('run', '-d', '--name', container, '--network', 'host',
  '--mount', `type=volume,source=${volume},target=/var/lib/light-github-action-provider`,
  '--mount', `type=volume,source=${secrets},target=/run/publication,readonly`,
  '-e', `GITHUB_ACTION_PROVIDER_ADDR=127.0.0.1:${port}`,
  '-e', `GITHUB_ACTION_PROVIDER_API_URL=http://127.0.0.1:${githubPort}/`,
  '-e', 'GITHUB_ACTION_PROVIDER_DB=/var/lib/light-github-action-provider/journal.sqlite',
  '-e', 'GITHUB_ACTION_PROVIDER_WORK_ROOT=/var/lib/light-github-action-provider/work',
  '-e', 'GITHUB_ACTION_PROVIDER_SERVICE_TOKEN_FILE=/run/publication/service',
  '-e', 'GITHUB_ACTION_PROVIDER_TOKEN_FILE=/run/publication/github',
  '-e', 'GITHUB_ACTION_PROVIDER_REPOSITORIES={"git@github.com:o/r.git":{"owner":"o","repo":"r"}}',
  '-e', `GITHUB_ACTION_PROVIDER_PUBLICATION_POLICY=${JSON.stringify(policy)}`, image);
const ready = async () => {
  for (let attempt = 0; attempt < 100; attempt++) {
    try {
      const response = await fetch(endpoint, { method: 'POST', body: '{}', headers: { 'content-type': 'application/json' } });
      if (response.status >= 400) return;
    } catch {}
    await new Promise(resolve => setTimeout(resolve, 100));
  }
  throw new Error('container provider did not become ready');
};
const call = (request, inspect = false) => fetch(endpoint + (inspect ? '/status' : ''), {
  method: 'POST', headers: { 'content-type': 'application/json', authorization: `Bearer ${token}` },
  body: JSON.stringify(request),
});
try {
  docker('volume', 'create', volume);
  docker('volume', 'create', secrets);
  docker('run', '--rm', '--user', 'root', '--entrypoint', '/bin/sh',
    '--mount', `type=bind,source=${directory},target=/seed,readonly`,
    '--mount', `type=volume,source=${secrets},target=/run/publication`,
    image, '-c', 'cp /seed/service /seed/github /run/publication/ && chown workflow:workflow /run/publication/service /run/publication/github && chmod 600 /run/publication/service /run/publication/github');
  start();
  await ready();
  for (const [index, destination] of [
    { kind: 'issue', title: 'Container qualification' },
    { kind: 'comment', issue: 1 },
    { kind: 'document', branch: 'qualification/publication', path: 'qualification/design.md' },
  ].entries()) {
    const digest = `sha256:${createHash('sha256').update('accepted fixture').digest('hex')}`;
    const request = { key: createHash('sha256').update(`${suffix}:${index}`).digest('hex'), body: 'Accepted fixture',
      plan: { featureId: suffix, slot: `slot-${index}`, revision: 1, candidateDigest: digest,
        repository: 'o/r', destination, content: { id: 'fixture', digest } } };
    const response = await call(request);
    assert(response.status >= 400, 'lost response must not produce confirmation');
    assert.equal(writes, index + 1);
    docker('stop', container);
    docker('rm', container);
    start();
    await ready();
    const observed = await call(request, true);
    assert.equal(observed.status, 200);
    const receipt = await observed.json();
    assert.equal(receipt.key, request.key);
    if (index === 2) assert.equal(receipt.commit, commit);
    const repeated = await call(request);
    assert.equal(repeated.status, 200);
    assert.deepEqual(await repeated.json(), receipt);
    const changed = await call({ ...request, body: 'changed' });
    assert(changed.status >= 400);
    assert.equal(writes, index + 1, 'restart, replay and changed retry must not duplicate writes');
  }
  console.log(JSON.stringify({ status: 'PASSED', image, writes, destinations: ['issue', 'comment', 'document'], qualification: 'provider-container-only' }));
} finally {
  await new Promise(resolve => server.close(resolve));
  try { docker('rm', '-f', container); } catch {}
  try { docker('volume', 'rm', volume, secrets); } catch {}
  // Private fixture files remain in the unique temporary directory; no tokens are printed.
}
