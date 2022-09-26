import { CancellationToken, CodeAction, CodeActionContext, CodeActionKind, CodeActionProvider, Command, ProviderResult, Range, Selection, TextDocument, window } from "vscode";
import { getTitleText } from "../utils/get-title-text";

export class ChangeModifierStyleAction implements CodeActionProvider {
    public provideCodeActions(document: TextDocument, range: Range | Selection, context: CodeActionContext, token: CancellationToken): CodeAction[] {
        const editor = window.activeTextEditor;
        if (!editor) { return []; }

        const selectedText = getTitleText(editor);
        if (selectedText === "") { return []; }
        if (selectedText === "Modifier") {
            return [
                {
                    command: "extension.change-to-cascading-modifier",
                    title: "Change Modifier to cascading style",
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
        if (selectedText === ".modified") {
            return [
                {
                    command: "extension.change-to-declarative-modifier",
                    title: "Change Modifier to declarative style",
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

        return [];


    }

}