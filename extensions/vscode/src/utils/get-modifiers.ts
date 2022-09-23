import { Position, Selection, TextEditor } from "vscode";
import { Property } from "./widget-transform";

const terminateChar = [',', ';'];

export const getModifiersSelectedText = (editor: TextEditor): Selection => {
    let lineText = editor.document.lineAt(editor.selection.start.line).text;
    let startAt = editor.selection.start.character;
    while (true) {
        if (lineText[startAt++] === ')') { break; }
    }

    let firstPosition = new Position(editor.selection.start.line, startAt);
    let limitLine = editor.document.lineCount - 1;
    let limitCharacter = editor.document.lineAt(editor.document.lineCount - 1).text.length;

    let limitPosition = new Position(
        limitLine,
        limitCharacter,
    );

    if (startAt === lineText.length) {
        firstPosition = new Position(editor.selection.start.line + 1, 0);
    }
    let lastPosition = firstPosition;

    while (lastPosition.isBefore(limitPosition)) {
        const lineText = editor.document.lineAt(lastPosition.line).text;
        const lastChar = lineText[lastPosition.character];
        if (terminateChar.includes(lastChar)) {
            const text = editor.document.getText(
                new Selection(firstPosition, lastPosition),
            );

            let bracketCount = 0;
            for (let index = 0; index < text.length; index++) {
                if (text[index] === '(') { bracketCount += 1; }
                if (text[index] === ')') { bracketCount -= 1; }
            }

            if (bracketCount <= 0) {
                const lastOffset = editor.document.offsetAt(lastPosition) + bracketCount;
                return new Selection(
                    firstPosition,
                    editor.document.positionAt(lastOffset),
                );
            }
        }
        if (lastPosition.character === lineText.length - 1) {
            lastPosition = new Position(lastPosition.line + 1, 0);
        } else {
            lastPosition = new Position(lastPosition.line, lastPosition.character + 1);
        }
    }

    return new Selection(editor.document.positionAt(0), editor.document.positionAt(0));
};

const parseModifier = (raw: string): Property => {
    let modifierPropertyNameIndex = raw.indexOf('(');
    let modifierPropertyName = raw.substring(0, modifierPropertyNameIndex);
    let modifierPropertyValue = raw.substring(modifierPropertyNameIndex + 1, raw.length - 1);

    return { name: modifierPropertyName.trim(), value: modifierPropertyValue.trim() };
};

export const getModifiers = (editor: TextEditor): Property[] => {
    let modifiers: Property[] = [];

    const modifierSelection = getModifiersSelectedText(editor);
    const raw = editor.document.getText(modifierSelection);
    let modifiableRaw = raw.trim();
    console.log(raw);
    let offset = -1;

    let bracketCount = 0;
    for (let index = 0; index < raw.length; index++) {
        offset++;
        let currChar = raw[index];
        if (currChar === '(') { bracketCount += 1; }
        if (currChar === ')') { bracketCount -= 1; }

        if (currChar === ')' && bracketCount === 0) {
            let modifierStr = modifiableRaw.substring(0, offset + 1).trim();
            modifiableRaw = modifiableRaw.substring(offset + 1).trim();
            modifierStr = modifierStr.substring(modifierStr.indexOf('(') + 1, modifierStr.length - 1);
            modifiers.push(parseModifier(modifierStr.trim()));
            offset = -1;
        }
    }

    return modifiers.reverse();
};