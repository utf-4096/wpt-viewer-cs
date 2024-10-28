import CoffeeScript from 'coffeescript';

export class ViteCoffeePlugin {
    name = 'coffee';

    transform(src, id) {
        if (!id.endsWith('.coffee')) {
            return null;
        }

        const { js, sourceMap } = CoffeeScript.compile(src, {
            bare: true,
            sourceMap: true,
            inlineMap: false,
        });

        return {
            code: js,
            map: {
                ...sourceMap.generate(),
                sources: [id],
            },
        };
    }
}

export default function coffee() {
    return new ViteCoffeePlugin();
}
