import 'package:flutter/material.dart';

import '../modifier.dart';

/// Overrides the default [ButtonStyle] of its [TextButton] descendants.
///
/// See also:
///
///  * [TextButtonThemeData], which is used to configure this theme.
///  * [TextButton.defaultStyleOf], which returns the default [ButtonStyle]
///    for text buttons.
///  * [TextButton.styleFrom], which converts simple values into a
///    [ButtonStyle] that's consistent with [TextButton]'s defaults.
///  * [ThemeData.textButtonTheme], which can be used to override the default
///    [ButtonStyle] for [TextButton]s below the overall [Theme].
class TextButtonThemeModifier extends SingleChildStatelessModifier {
  /// Create a [TextButtonTheme].
  ///
  /// The [data] parameter must not be null.
  const TextButtonThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The configuration of this theme.
  final TextButtonThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextButtonTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
