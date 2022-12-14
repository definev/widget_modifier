import { commands, ExtensionContext, languages } from 'vscode';

import { ChangeModifierStyleAction, WidgetToModifierCodeActions } from './code-actions';
import { changeToCascadingModifierCommand, changeToDeclarativeModifierCommand, convertToCascadingModifierCommand, convertToDeclarativeModifierCommand, wrapWithModifierCommand } from './commands';

const DART_MODE = { language: "dart", scheme: "file" };

export function activate(_context: ExtensionContext) {
	_context.subscriptions.push(
		commands.registerCommand("extension.wrap-modifier", wrapWithModifierCommand),
		commands.registerCommand("extension.convert-to-declarative-modifier", convertToDeclarativeModifierCommand),
		commands.registerCommand("extension.convert-to-cascading-modifier", convertToCascadingModifierCommand),
		commands.registerCommand("extension.change-to-declarative-modifier", changeToDeclarativeModifierCommand),
		commands.registerCommand("extension.change-to-cascading-modifier", changeToCascadingModifierCommand),
		languages.registerCodeActionsProvider(
			DART_MODE,
			new WidgetToModifierCodeActions(),
		),
		languages.registerCodeActionsProvider(
			DART_MODE,
			new ChangeModifierStyleAction(),
		),
	);
}

// this method is called when your extension is deactivated
export function deactivate() { }
