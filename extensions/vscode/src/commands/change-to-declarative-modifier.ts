import { commands, Selection, SnippetString, window } from "vscode";
import { getModifiers, getModifiersSelectedText as getModifiersSelectedText } from "../utils";
import { getCascadingSelectedText } from "../utils/get-cascading-selected-text";

export const changeToDeclarativeModifierCommand = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const childSelection = getCascadingSelectedText(editor);
    const modifierSelection = getModifiersSelectedText(editor);
    const child = editor.document.getText(childSelection).replace("$", "\\$");
    const modifiers = getModifiers(editor);
    const snippet = `Modifier(
        modifiers: [
            ${modifiers.map((prop) => `${prop.name}(${prop.value}),`).join('')}
        ],
        child: ${child},
    )`;
    editor.insertSnippet(
        new SnippetString(snippet),
        new Selection(
            childSelection.start,
            modifierSelection.end,
        ),
    );
    await commands.executeCommand("editor.action.formatDocument");
    editor.selection = new Selection(childSelection.start, childSelection.start);
    editor.revealRange(editor.document.lineAt(childSelection.start.line).range);
};
