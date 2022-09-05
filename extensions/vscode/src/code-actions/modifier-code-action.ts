import { CodeActionProvider, CodeAction, window, CodeActionKind, ExtensionContext } from 'vscode';
import { getSelectedText } from '../utils';

export class ModifierCodeActions implements CodeActionProvider {
    public static readonly providedCodeActionKinds = [
        CodeActionKind.Refactor
    ];

    public provideCodeActions(): CodeAction[] {
        const editor = window.activeTextEditor;
        if (!editor) { return []; }

        const selectedText = editor.document.getText(getSelectedText(editor));
        if (selectedText === "") { return []; }

        return [
            {
                command: "extension.wrap-modifier",
                title: "Wrap with Modifier",
                codeActionKind: CodeActionKind.Refactor,
            },
            {
                command: "extension.convert-modifier",
                title: "Convert to Modifier",
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