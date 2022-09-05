import { commands, ExtensionContext, languages } from 'vscode';

import { ModifierCodeActions } from './code-actions';
import { refactorModifierCommand, wrapWithModifierCommand } from './commands';

const DART_MODE = { language: "dart", scheme: "file" };

export function activate(_context: ExtensionContext) {
	_context.subscriptions.push(
		commands.registerCommand("extension.wrap-modifier", wrapWithModifierCommand),
		commands.registerCommand("extension.convert-modifier", refactorModifierCommand),
		languages.registerCodeActionsProvider(
			DART_MODE,
			new ModifierCodeActions(),
		),
	);
}

// this method is called when your extension is deactivated
export function deactivate() { }
