import { window } from "vscode";
import { getCascadingSelectedText } from "../utils/get-cascading-selected-text";

export const changeToDeclarativeModifierCommand = async () => {
    let editor = window.activeTextEditor;
    if (!editor) { return; }
    const selection = getCascadingSelectedText(editor);
    const widget = `${editor.document.getText(selection).replace("$", "\\$")},`;
    console.log(widget);
};