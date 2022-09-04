import { window, commands, SnippetString } from "vscode";
import { getSelectedText } from "../utils";

export const wrapWith = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getSelectedText(editor);
    const widget = editor.document.getText(selection).replace("$", "\\$");
    console.log(widget);
    // editor.insertSnippet(new SnippetString(snippet(widget)), selection);
    await commands.executeCommand("editor.action.formatDocument");
};
