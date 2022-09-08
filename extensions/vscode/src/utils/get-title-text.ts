import { Position, Selection, TextEditor } from "vscode";

const openBracket = "(";
const closeBracket = ")";

export const getTitleText = (editor: TextEditor): String => {
    const language = editor.document.languageId;
    if (language !== "dart") { return ""; }

    const line = editor.document.lineAt(editor.selection.start);
    const lineText = line.text;
    const openBracketIndex = line.text.indexOf(
        openBracket,
        editor.selection.anchor.character
    );

    let widgetStartIndex =
        openBracketIndex > 1
            ? openBracketIndex - 1
            : editor.selection.anchor.character;
    for (widgetStartIndex; widgetStartIndex > 0; widgetStartIndex--) {
        const currentChar = lineText.charAt(widgetStartIndex);
        const isBeginningOfWidget =
            currentChar === openBracket ||
            (currentChar === " " && lineText.charAt(widgetStartIndex - 1) !== ",");
        if (isBeginningOfWidget) { break; }
    }
    widgetStartIndex++;

    const text = lineText.substring(widgetStartIndex, openBracketIndex);

    return text;
};