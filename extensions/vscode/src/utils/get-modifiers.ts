import { Position, Selection, TextEditor } from "vscode";
import { Property } from "./widget-transform";

const terminateChar = [',', ';'];

export const getModifiersSelection = (editor: TextEditor): Selection => {
    let lineText = editor.document.lineAt(editor.selection.start.line).text;
    let startAt = editor.selection.start.character;
    while (true) {
        if (lineText[startAt++] === ')') { break; }
    }

    let firstPosition = new Position(editor.selection.start.line, startAt);
    let lastPosition = firstPosition;
    let limitLine = editor.document.lineCount - 1;
    let limitCharacter = editor.document.lineAt(editor.document.lineCount - 1).text.length;

    let limitPosition = new Position(
        limitLine,
        limitCharacter,
    );

    if (startAt === lineText.length) {
        firstPosition = new Position(editor.selection.start.line + 1, 0);
    }
    while (lastPosition.isBefore(limitPosition)) {
        const lineText = editor.document.lineAt(lastPosition.line).text;
        if (terminateChar.includes(lineText[lastPosition.character])) {
            const text = editor.document.getText(
                new Selection(firstPosition, lastPosition),
            );

            let bracketCount = 0;
            for (let index = 0; index < text.length; index++) {
                if (text[index] === '(') { bracketCount += 1; }
                if (text[index] === ')') { bracketCount -= 1; }
            }

            if (bracketCount === 0) {
                return new Selection(
                    firstPosition,
                    new Position(
                        lastPosition.character === 0
                            ? lastPosition.line - 1
                            : lastPosition.line,
                        lastPosition.character === 0
                            ? editor.document.lineAt(lastPosition.line - 1).text.length - 1
                            : lastPosition.character - 1,
                    ),
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

const getModifiersRawText = (editor: TextEditor): string => {
    let result = editor.document.getText(getModifiersSelection(editor));
    console.log(result);
    return result;
};

export const getModifiers = (editor: TextEditor): Property[] => {
    let modifiers: Property[] = [];

    let raw = getModifiersRawText(editor);

    let modifiersRaw = raw.split(".add");
    // Remove first empty property
    modifiers.shift();

    for (let index = 0; index < modifiersRaw.length; index++) {
        let modifierStr = modifiersRaw[index];
        let modifyFuncIndex = modifierStr.indexOf('(');
        let modifyFunc = modifierStr.substring(0, modifyFuncIndex - 1);
        if (modifyFunc === 'add') {
            modifierStr = modifierStr.substring(4, modifierStr.length);
            let modifierPropertyNameIndex = modifierStr.indexOf('(');
            let modifierPropertyName = modifierStr.substring(0, modifierPropertyNameIndex);
            let modifierPropertyValue = modifierStr.substring(modifierPropertyNameIndex, modifierStr.length - 1);
            modifiers.push({ name: modifierPropertyName, value: modifierPropertyValue });
        }
    }

    return modifiers;
};