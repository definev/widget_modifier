import 'package:flutter/material.dart';

import '../modifier.dart';

/// Overrides the default [ExpansionTileTheme] of its [ExpansionTile] descendants.
///
/// See also:
///
///  * [ExpansionTileThemeData], which is used to configure this theme.
///  * [ThemeData.expansionTileTheme], which can be used to override the default
///    [ExpansionTileTheme] for [ExpansionTile]s below the overall [Theme].
class ExpansionTileThemeModifier extends SingleChildStatelessModifier {
  /// Applies the given theme [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  const ExpansionTileThemeModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.data,
  });

  /// Specifies color, alignment, and text style values for
  /// descendant [ExpansionTile] widgets.
  final ExpansionTileThemeData data;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [ExpansionTileTheme] widget, then
  /// [ThemeData.expansionTileTheme] is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// ExpansionTileThemeData theme = ExpansionTileTheme.of(context);
  /// ```
  static ExpansionTileThemeData of(BuildContext context) {
    final ExpansionTileTheme? inheritedTheme = context.dependOnInheritedWidgetOfExactType<ExpansionTileTheme>();
    return inheritedTheme?.data ?? Theme.of(context).expansionTileTheme;
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ExpansionTileTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
