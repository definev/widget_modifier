import { commands, SnippetString, window } from "vscode";
import { getSelectedText, parseRecursive, widgetsToCascadingModifierSnippet } from "../utils";

export const convertToCascadingModifierCommand = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getSelectedText(editor);
    const widget = `${editor.document.getText(selection).replace("$", "\\$")},`;
    const widgets = parseRecursive(widget);
    if (widgets.length === 0) {
        window.showInformationMessage('This widget can\'t convert to Modifier');
        return;
    }
    const snippet = widgetsToCascadingModifierSnippet(widgets);
    if (snippet === null) { return; }
    editor.insertSnippet(new SnippetString(snippet), selection);
    await commands.executeCommand("editor.action.formatDocument");
};