import { CodeActionProvider, CodeAction, window, CodeActionKind, ExtensionContext, TextDocument } from 'vscode';
import { getSelectedText } from '../utils';
import { getTitleText } from '../utils/get-title-text';

export class WidgetToModifierCodeActions implements CodeActionProvider {
    public provideCodeActions(document: TextDocument): CodeAction[] {
        const editor = window.activeTextEditor;
        if (!editor) { return []; }

        const title = getTitleText(editor);
        if (title === 'Modifier' || title === 'modified') { return []; }

        const selectedText = document.getText(getSelectedText(editor));
        if (selectedText === "") { return []; }

        return [
            {
                command: "extension.wrap-modifier",
                title: "Wrap with Modifier",
                codeActionKind: CodeActionKind.Refactor,
            },
            {
                command: "extension.convert-to-declarative-modifier",
                title: "Convert to declarative Modifier",
                codeActionKind: CodeActionKind.QuickFix,
            },
            {
                command: "extension.convert-to-cascading-modifier",
                title: "Convert to cascading Modifier", 
                codeActionKind: CodeActionKind.QuickFix,
            },
        ].map((c) => {
            let action = new CodeAction(c.title, c.codeActionKind);
            action.command = {
                title: c.title,
                command: c.command,
            };
            return action;
        });
    }
}