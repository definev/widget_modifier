import { commands, Selection, SnippetString, window } from "vscode";
import { getSelectedText, parseToWidgets, widgetsToCascadingModifierSnippet } from "../utils";

export const convertToCascadingModifierCommand = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getSelectedText(editor);
    const widget = `${editor.document.getText(selection).replace("$", "\\$")},`;
    const widgets = parseToWidgets(widget);
    if (widgets.length === 0) {
        window.showInformationMessage('This widget can\'t convert to Modifier');
        return;
    }

    const snippet = widgetsToCascadingModifierSnippet(widgets);
    if (snippet === null) { return; }
    await editor.insertSnippet(new SnippetString(snippet), selection);

    const child = widgets[widgets.length - 1].getChild()!;
    const newOffset = editor.document.offsetAt(selection.start) + child.length - 1;
    const newStartPosition = editor.document.positionAt(newOffset);
    editor.selection = new Selection(newStartPosition, newStartPosition);
    await commands.executeCommand("editor.action.formatDocument");
    editor.revealRange(editor.document.lineAt(editor.selection.start.line).range);
};