import { Position, Selection, TextEditor } from "vscode";

const getPotentialFirstPosition = (editor: TextEditor, position: Position): Position => {
    if (position.character === 0) {
        return new Position(position.line - 1, editor.document.lineAt(position.line - 1).text.length - 1);
    }
    return new Position(position.line, position.character - 1);
};

export const getCascadingSelectedText = (editor: TextEditor): Selection => {
    const emptySelection = new Selection(
        editor.document.positionAt(0),
        editor.document.positionAt(0)
    );
    const language = editor.document.languageId;
    if (language !== "dart") { return emptySelection; }

    const line = editor.document.lineAt(editor.selection.start);
    const lineText = line.text;
    let founded = false;
    let lastPosition = new Position(editor.selection.start.line, 0);

    for (let index = editor.selection.start.character; index >= 0; index--) {
        if (founded) {
            lastPosition = new Position(editor.selection.start.line, index);;
            break;
        }
        const currChar = lineText[index];
        if (currChar === ".") {
            founded = true;
        }
    }

    let firstPosition = lastPosition;
    let done = false;
    while (!done) {
        firstPosition = getPotentialFirstPosition(editor, firstPosition);
        let currChar = editor.document.lineAt(firstPosition.line).text[firstPosition.character];
        if (currChar === '(') {
            const text = editor.document.getText(
                new Selection(firstPosition, lastPosition),
            );
            let bracketCount = 0;
            for (let index = 0; index < text.length; index++) {
                const textCurrChar = text[index];
                if (textCurrChar === '(') { bracketCount -= 1; }
                if (textCurrChar === ')') { bracketCount += 1; }
            }

            if (bracketCount === 0) {
                let firstLineText = editor.document.lineAt(firstPosition.line).text;
                for (let firstLineIndex = firstPosition.character; firstLineIndex >= 0; firstLineIndex--) {
                    if (firstLineText[firstLineIndex] === ' ') {
                        firstPosition = new Position(firstPosition.line, firstLineIndex + 1);
                        done = true;
                        break;
                    }
                }
            }
            if (firstPosition === new Position(0, 0)) {
                break;
            }
        }
    }

    return new Selection(firstPosition, lastPosition);
};