import { defineConfig } from 'vite';
import { join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import svgr from 'vite-plugin-svgr';
import coffee from './vite/ViteCoffeePlugin.js';
import coffeeJsx from './vite/ViteCoffeeJSXPlugin.js';

const dirname = fileURLToPath(new URL('.', import.meta.url));

export default defineConfig({
    base: './',
    clearScreen: false,
    build: {
        outDir: resolve('dist'),
        emptyOutDir: true,
    },

    root: join(dirname, './src/web/'),
    resolve: {
        alias: {
            'react': 'preact/compat',
            'react-dom/test-utils': 'preact/test-utils',
            'react-dom': 'preact/compat',
            'react/jsx-runtime': 'preact/jsx-runtime',
        },
    },

    plugins: [
        svgr(),
        coffee(),
        coffeeJsx(),
    ],
});
