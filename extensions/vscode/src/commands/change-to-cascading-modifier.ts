import { commands, SnippetString, window } from "vscode";
import { getSelectedText, parseToWidgets } from "../utils";

export const changeToCascadingModifierCommand = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getSelectedText(editor);
    const widget = `${editor.document.getText(selection).replace("$", "\\$")},`;
    const widgets = parseToWidgets(widget);
    const cascadingStyle = widgets[0].changeWidgetToCascadingStyle();

    editor.insertSnippet(new SnippetString(cascadingStyle), selection);
    await commands.executeCommand("editor.action.formatDocument");
};