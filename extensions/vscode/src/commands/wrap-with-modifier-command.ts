import { wrapWith } from "../utils";

const wrapWithModifierSnippet = (widget: string): string => {
    return `Modifier(
        modifiers: [
            // TODO: Add at least one \`Modifier\`
        ],
        child: ${widget},
    )`;
}

export const wrapWithModifierCommand = async () => wrapWith(wrapWithModifierSnippet);
