import { TextEditor } from "vscode";
import { Property } from "./widget-transform";

const getModifiersRawText = (editor: TextEditor): string => {
    let result = "";
    return result;
};

export const getModifiers = (editor: TextEditor): Property[] => {
    let modifiers: Property[] = [];

    let raw = getModifiersRawText(editor);

    let modifiersRaw = raw.split(".");
    // Remove first empty property
    modifiers.shift();

    for (let index = 0; index < modifiersRaw.length; index++) {
        let modifierStr = modifiersRaw[index];
        let modifyFuncIndex = modifierStr.indexOf('(');
        let modifyFunc = modifierStr.substring(0, modifyFuncIndex - 1);
        if (modifyFunc === 'add') {
            modifierStr = modifierStr.substring(4, modifierStr.length);
            let modifierPropertyNameIndex = modifierStr.indexOf('(');
            let modifierPropertyName = modifierStr.substring(0, modifierPropertyNameIndex);
            let modifierPropertyValue = modifierStr.substring(modifierPropertyNameIndex, modifierStr.length - 1);
            modifiers.push({ name: modifierPropertyName, value: modifierPropertyValue });
        }
    }

    return modifiers;
};