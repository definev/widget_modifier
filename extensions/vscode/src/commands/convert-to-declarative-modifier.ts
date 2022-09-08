import { commands, SnippetString, window } from "vscode";
import { getSelectedText, parseRecursive, widgetsToSnippet } from "../utils";

// const refactorModifierSnippet = (modifiers: string[], child: string): string => {
//     return `Modifier(
//         modifiers: [
//             ${modifiers.join(',')},
//         ],
//         child: ${child},
//     )`;
// }

export const convertToDeclarativeModifierCommand = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getSelectedText(editor);
    const widget = `${editor.document.getText(selection).replace("$", "\\$")},`;
    const widgets = parseRecursive(widget);
    const snippet = widgetsToSnippet(widgets);
    editor.insertSnippet(new SnippetString(snippet), selection);
    await commands.executeCommand("editor.action.formatDocument");
};
