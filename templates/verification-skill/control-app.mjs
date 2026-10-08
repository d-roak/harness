#!/usr/bin/env node
import { readFile } from 'node:fs/promises'

const commands = new Set(['doctor', 'home'])
const [command, ...args] = process.argv.slice(2)

function fail(message) {
	throw new Error(`control-app: ${message}`)
}

function origin(value) {
	const url = new URL(value)
	if (url.protocol !== 'http:' || url.username || url.password || !['localhost', '127.0.0.1', '[::1]'].includes(url.hostname)) {
		fail('origin must be an unauthenticated http localhost URL')
	}
	return url.origin
}

async function config() {
	let raw
	try {
		raw = await readFile(new URL('./config.json', import.meta.url), 'utf8')
	} catch {
		fail('missing config.json; copy config.example.json and fill every field')
	}
	const value = JSON.parse(raw)
	if (!value || typeof value !== 'object' || Array.isArray(value) || Object.keys(value).length !== 4 || typeof value.origin !== 'string' || typeof value.devCommand !== 'string' || typeof value.testData !== 'string' || typeof value.auth !== 'string' || Object.values(value).some((field) => !field.trim() || field.startsWith('fill '))) {
		fail('config.json must contain only filled origin, devCommand, testData, and auth strings')
	}
	return { ...value, origin: origin(value.origin) }
}

if (!command || !commands.has(command)) fail(`unknown command; allowed: ${[...commands].join(', ')}`)
const settings = await config()
if (command === 'doctor') {
	console.log(JSON.stringify({ origin: settings.origin, configured: true, next: 'install or reuse your app Playwright/CDP driver, then replace this template command' }))
	process.exit(0)
}
if (command === 'home' && args.length === 0) {
	console.log(JSON.stringify({ origin: settings.origin }))
	process.exit(0)
}
fail(`${command} is a template stub. Connect it to this app's existing runtime driver, add a seam test, and document it in the Feature Map.`)
