import PluginReactJSX from '@babel/plugin-transform-react-jsx';
import babel from '@babel/core';

export class ViteCoffeeJSXPlugin {
    name = 'coffee-jsx';

    transform(src, id) {
        if (!id.endsWith('.coffee')) {
            return null;
        }

        return babel.transformSync(src, {
            plugins: [
                [PluginReactJSX, {
                    runtime: 'automatic',
                    importSource: 'preact',
                }],
            ],
        });
    }
}

export default function coffeeJsx() {
    return new ViteCoffeeJSXPlugin();
}
