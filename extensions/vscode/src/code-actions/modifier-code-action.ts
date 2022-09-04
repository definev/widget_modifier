import { CodeActionProvider, CodeAction, window, CodeActionKind, ExtensionContext } from 'vscode';

export class ModifierCodeActions implements CodeActionProvider {
    context: ExtensionContext;

    constructor(context: ExtensionContext) {
        this.context = context;
    }

    public provideCodeActions(): CodeAction[] {
        return [
            {
                command: "extension.wrap-with-modifier",
                title: "Wrap with Modifier",
            },
            {
                command: "extension.refactor-modifier",
                title: "Refactor to Modifier",
            },
        ].map((c) => {
            let action = new CodeAction(c.title, CodeActionKind.Refactor);
            action.command = {
                command: c.command,
                title: c.title,
            };
            return action;
        });
    }
}