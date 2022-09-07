import { commands, SnippetString, window } from "vscode";
import { getSelectedText } from "./get-selected-text";

type Property = { name: string, value: string };

const notValidChar = [',', ')'];

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
                if (nextChar === ',') {
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
            if (text[index] === '(' || text[index] === '{' || text[index] === '[') { totalBracket += 1; }
            if (text[index] === ')' || text[index] === '}' || text[index] === ']') { totalBracket -= 1; }
        }

        return totalBracket;
    }

    public getModifier(): string {
        return `${this.name}Modifier(
            ${ this.key !== null ? `modifierKey: ${this.key.value}` : ''}
            ${this.properties.map(({ name, value }) => `${name}: ${value},`).join('')}
            ${this.builder !== null ? `builder: ${this.builder.value},` : '' }
        )`;
    }

    public getChild(): string | undefined {
        return this.child?.value;
    }

    public hasChild() {
        return this.child !== null;
    }
}

const parseRecursive = (raw: string): Widget[] => {
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

const widgetsToSnippet = (widgets: Widget[]): string => {
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

export const convertTo = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getSelectedText(editor);
    const widget = `${editor.document.getText(selection).replace("$", "\\$")},`;
    const widgets = parseRecursive(widget);
    const snippet = widgetsToSnippet(widgets);
    editor.insertSnippet(new SnippetString(snippet), selection);
    await commands.executeCommand("editor.action.formatDocument");
};