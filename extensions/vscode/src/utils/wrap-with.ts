import { window, commands, SnippetString, Selection } from "vscode";
import { getSelectedText } from "../utils";

export const wrapWith = async (snippet: (widget: string) => string) => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getSelectedText(editor);
    const widget = editor.document.getText(selection).replace("$", "\\$");
    editor.insertSnippet(new SnippetString(snippet(widget)), selection);
    await commands.executeCommand("editor.action.formatDocument");
    editor.selection = new Selection(selection.start, selection.start);
    editor.revealRange(editor.document.lineAt(editor.selection.start.line).range);
};
