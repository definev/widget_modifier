import 'package:flutter/material.dart';

import '../modifier.dart';

/// Overrides the default [ButtonStyle] of its [ElevatedButton] descendants.
///
/// See also:
///
///  * [ElevatedButtonThemeData], which is used to configure this theme.
///  * [ElevatedButton.defaultStyleOf], which returns the default [ButtonStyle]
///    for elevated buttons.
///  * [ElevatedButton.styleFrom], which converts simple values into a
///    [ButtonStyle] that's consistent with [ElevatedButton]'s defaults.
///  * [ThemeData.elevatedButtonTheme], which can be used to override the default
///    [ButtonStyle] for [ElevatedButton]s below the overall [Theme].
class ElevatedButtonThemeModifier extends SingleChildStatelessModifier {
  /// Create a [ElevatedButtonTheme].
  ///
  /// The [data] parameter must not be null.
  const ElevatedButtonThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The configuration of this theme.
  final ElevatedButtonThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ElevatedButtonTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
