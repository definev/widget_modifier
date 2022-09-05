import { convertTo } from "../utils";

// const refactorModifierSnippet = (modifiers: string[], child: string): string => {
//     return `Modifier(
//         modifiers: [
//             ${modifiers.join(',')},
//         ],
//         child: ${child},
//     )`;
// }

export const refactorModifierCommand = async () => convertTo();
