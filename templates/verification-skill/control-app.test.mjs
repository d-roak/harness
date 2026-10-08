import assert from 'node:assert/strict'
import { cp, mkdtemp, writeFile } from 'node:fs/promises'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import { execFileSync } from 'node:child_process'

const directory = await mkdtemp(join(tmpdir(), 'verify-app-'))
const control = new URL('./control-app.mjs', import.meta.url)
const copied = join(directory, 'control-app.mjs')
await cp(control, copied)
const run = (...args) => execFileSync(process.execPath, [copied, ...args], { encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'] })

assert.throws(() => run('doctor'), /missing config.json/)
await writeFile(join(directory, 'config.json'), JSON.stringify({ origin: 'https://example.com', devCommand: 'x', testData: 'x', auth: 'x' }))
assert.throws(() => run('doctor'), /localhost/)
await writeFile(join(directory, 'config.json'), JSON.stringify({ origin: 'http://localhost:3000', devCommand: 'x', testData: 'x', auth: 'x' }))
assert.equal(JSON.parse(run('doctor')).origin, 'http://localhost:3000')
assert.throws(() => run('snapshot'), /unknown command/)
