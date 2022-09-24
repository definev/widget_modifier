import { commands, Selection, SnippetString, window } from "vscode";
import { getSelectedText, parseToWidgets } from "../utils";

export const changeToCascadingModifierCommand = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getSelectedText(editor);
    const widget = `${editor.document.getText(selection).replace("$", "\\$")},`;
    const widgets = parseToWidgets(widget);
    const cascadingStyle = widgets[0].changeWidgetToCascadingStyle();
    const newOffset = editor.document.offsetAt(selection.start) + widgets[0].getChild()!.length;
    await editor.insertSnippet(new SnippetString(cascadingStyle), selection);
    const newSelection = new Selection(
        editor.document.positionAt(newOffset),
        editor.document.positionAt(newOffset),
    );
    editor.selection = newSelection;
    await commands.executeCommand("editor.action.formatDocument");
    editor.revealRange(editor.document.lineAt(editor.selection.start.line).range);
};