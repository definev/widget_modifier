import { window } from "vscode";

type Property = { name: string, value: string };

const notValidChar = [',', ')'];
const openBrackets = ['(', '{', '['];
const closeBrackets = [')', '}', ']'];
const terminateChar = [',', ';'];

class Widget {
    constructor(
        name: string,
        properties: Property[],
        key: Property | null,
        child: Property | null,
        builder: Property | null,
    ) {
        this.name = name;
        this.properties = properties;
        this.key = key;
        this.child = child;
        this.builder = builder;
    }

    name: string;
    private key: Property | null;
    private child: Property | null;
    private builder: Property | null;
    private properties: Property[];

    public static parse(raw: string): Widget {
        raw = raw.trim();
        let name: string = '';
        let key: Property | null = null;
        let child: Property | null = null;
        let builder: Property | null = null;
        let properties: Property[] = [];

        let termText: string = '';
        let property: Property = { name: '', value: '' };

        function classifyProperty(property: Property) {
            if (property.name === 'key') {
                key = property;
                return;
            }
            if (property.name === 'child') {
                // Need to add `,` for terminator
                property.value = property.value + ',';
                child = property;
                return;
            }
            if (property.name === 'builder') {
                builder = property;
                return;
            }

            properties.push(property);
        }

        for (let index = 0; index < raw.length; index += 1) {
            const nextChar = raw[index];
            if (name === '') {
                if (nextChar !== '(') {
                    termText += nextChar;
                } else {
                    name = termText;
                    termText = '';
                }
                continue;
            }

            if (nextChar === '\n') {
                continue;
            }
            if (property.name !== '') {
                // Use `,` as a terminator to check the full expression
                if (terminateChar.includes(nextChar)) {
                    termText = termText.trim().replace('\n', '');
                    const bracketState = this.getBracketState(termText);

                    if (bracketState === 0) {
                        property.value = termText;
                        classifyProperty(property);
                        property = { name: '', value: '' };
                        termText = '';
                        continue;
                    }
                    if (bracketState < 0) {
                        property.value = termText.substring(0, termText.length + bracketState - 1);
                        classifyProperty(property);
                        property = { name: '', value: '' };
                        termText = '';
                        continue;
                    }
                }
                termText += nextChar;
                continue;
            }

            if (notValidChar.includes(nextChar)) {
                continue;
            }
            if (nextChar === ':') {
                property.name = termText.trim();
                termText = '';
            } else {
                termText += nextChar;
            }
        }

        return new Widget(name, properties, key, child, builder);
    }

    public static getBracketState(text: string): number {
        let totalBracket = 0;

        for (let index = 0; index < text.length; index += 1) {
            const currChar = text[index];
            if (openBrackets.includes(currChar)) { totalBracket += 1; }
            if (closeBrackets.includes(currChar)) { totalBracket -= 1; }
        }

        return totalBracket;
    }

    public getModifier(): string {
        return `${this.name}Modifier(
            ${this.key !== null ? `modifierKey: ${this.key.value}` : ''}
            ${this.properties.map(({ name, value }) => `${name}: ${value},`).join('')}
            ${this.builder !== null ? `builder: ${this.builder.value},` : ''}
        )`;
    }

    public getChild(): string | undefined {
        return this.child?.value;
    }

    public hasChild() {
        return this.child !== null;
    }
}

export const parseRecursive = (raw: string): Widget[] => {
    let widgets: Widget[] = [];
    let widget: Widget | undefined;
    let source: string = raw;

    while (true) {
        widget = Widget.parse(source);
        if (!widget.hasChild()) { break; }
        widgets.push(widget);
        source = widget.getChild() as string;
    }

    return widgets;
};

export const widgetsToDeclarativeModifierSnippet = (widgets: Widget[]): string => {
    const modifiers = widgets.map(w => w.getModifier()).join(',');
    console.log(modifiers);
    const child = widgets[widgets.length - 1].getChild();
    if (child === undefined) {
        return `Modifier(
            modifiers: [${modifiers}],
        )`;
    }

    return `Modifier(
        modifiers: [${modifiers}],
        child: ${child}
    )`;
};


export const widgetsToCascadingModifierSnippet = (widgets: Widget[]): string | null => {
    const modifiers = widgets.map(w => `.add(${w.getModifier()})`).reverse().join('');
    console.log(modifiers);
    const child = widgets[widgets.length - 1].getChild();
    if (child === undefined) {
        window.showWarningMessage("Cascading widget must have at least one child");
        return null;
    }

    let modifierChild = child.substring(0, child.length - 1);

    return `${modifierChild}
        .modified() //
        ${modifiers}
    `;
};
