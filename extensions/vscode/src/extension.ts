import { commands, ExtensionContext, languages } from 'vscode';

import { WidgetToModifierCodeActions } from './code-actions';
import { convertToCascadingModifierCommand, convertToDeclarativeModifierCommand, wrapWithModifierCommand } from './commands';

const DART_MODE = { language: "dart", scheme: "file" };

export function activate(_context: ExtensionContext) {
	_context.subscriptions.push(
		commands.registerCommand("extension.wrap-modifier", wrapWithModifierCommand),
		commands.registerCommand("extension.convert-to-declarative-modifier", convertToDeclarativeModifierCommand),
		commands.registerCommand("extension.convert-to-cascading-modifier", convertToCascadingModifierCommand),
		languages.registerCodeActionsProvider(
			DART_MODE,
			new WidgetToModifierCodeActions(),
		),
	);
}

// this method is called when your extension is deactivated
export function deactivate() { }
