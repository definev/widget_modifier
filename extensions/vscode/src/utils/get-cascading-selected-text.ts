import { Position, Selection, TextEditor } from "vscode";

const openBrackets = ['(', '{', '['];
const closeBrackets = [')', '}', ']'];

export const getCascadingSelectedText = (editor: TextEditor): Selection => {
    const emptySelection = new Selection(
        editor.document.positionAt(0),
        editor.document.positionAt(0)
    );
    const language = editor.document.languageId;
    if (language !== "dart") { return emptySelection; }

    const line = editor.document.lineAt(editor.selection.start);
    const lineText = line.text;
    let openBracketIndex = Number.MAX_VALUE;
    for (let openBracket in openBrackets) {
        let bracket = line.text.indexOf(
            openBracket,
            editor.selection.anchor.character
        );
        if (bracket < openBracketIndex) {
            openBracketIndex = bracket;
        }
    }

    let widgetStartIndex = openBracketIndex > 1
        ? openBracketIndex - 1
        : editor.selection.anchor.character;
    for (widgetStartIndex; widgetStartIndex > 0; widgetStartIndex--) {
        const currentChar = lineText.charAt(widgetStartIndex);
        const isBeginningOfWidget =
            openBrackets.includes(currentChar) ||
            (currentChar === " " && lineText.charAt(widgetStartIndex - 1) !== ",");
        if (isBeginningOfWidget) { break; }
    }
    widgetStartIndex++;

    let currentLine = editor.selection.start.line;
    let startIndex = widgetStartIndex;

    let startPosition = new Position(currentLine, startIndex);
    let openBracketCount = 0;

    let endLine = currentLine;
    let endIndex = startIndex;


    for (endLine; endLine < editor.document.lineCount; endLine++) {
        let lineText = editor.document.lineAt(currentLine).text;
        for (endIndex; endIndex < lineText.length; endIndex++) {
            const currChar = lineText[endIndex];
            if (openBrackets.includes(currChar)) { openBracketCount++; }
            if (closeBrackets.includes(currChar)) { openBracketCount--; }

            if (currChar === ',') {
                if (openBracketCount === 0) { break; }
                if (openBracketCount <= 0) {
                    openBracketCount = -openBracketCount;
                    for (let charLeft = 0; charLeft < openBracketCount; charLeft++) {
                        if (endIndex === 0) {
                            endLine = endLine - 1;
                            endIndex = editor.document.lineAt(endLine).text.length;
                        } else {
                            endIndex = endIndex - 1;
                        }
                    }
                    break;
                }
            }
        }
    }

    let endPosition = new Position(endLine, endIndex);

    return new Selection(startPosition, endPosition);
};