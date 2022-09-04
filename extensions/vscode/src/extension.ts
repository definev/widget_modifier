import { commands, ExtensionContext, languages } from 'vscode';

import { ModifierCodeActions } from './code-actions';
import { refactorModifierCommand, wrapWithModifierCommand } from './commands';

const DART_MODE = { language: "dart", scheme: "file" };

export function activate(context: ExtensionContext) {
	context.subscriptions.push(
		commands.registerCommand('extension.wrap-with-modifier', wrapWithModifierCommand),
		commands.registerCommand('extension.refactor-modifier', refactorModifierCommand),
	);

	const provider = new ModifierCodeActions(context);
	const codeAction = languages.registerCodeActionsProvider(DART_MODE, provider);

	context.subscriptions.push(codeAction);
}

// this method is called when your extension is deactivated
export function deactivate() { }
