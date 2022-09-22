import { commands, SnippetString, window } from "vscode";
import { getModifiers } from "../utils";
import { getCascadingSelectedText } from "../utils/get-cascading-selected-text";

export const changeToDeclarativeModifierCommand = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getCascadingSelectedText(editor);
    const child = editor.document.getText(selection).replace("$", "\\$");
    const modifiers = getModifiers(editor);
    const snippet = `Modifier(
        modifiers: [
            ${modifiers.map((prop) => `${prop.name}(${prop.value}),`).join('')}
        ],
        child: ${child},
    )`;
    editor.insertSnippet(new SnippetString(snippet), selection);
    await commands.executeCommand("editor.action.formatDocument");
};
