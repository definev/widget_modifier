import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines the configuration for
/// [Divider]s, [VerticalDivider]s, dividers between [ListTile]s, and dividers
/// between rows in [DataTable]s in this widget's subtree.
class DividerThemeModifier extends SingleChildStatelessModifier {
  /// Creates a divider theme that controls the configurations for
  /// [Divider]s, [VerticalDivider]s, dividers between [ListTile]s, and dividers
  /// between rows in [DataTable]s in its widget subtree.
  const DividerThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties for descendant [Divider]s, [VerticalDivider]s, dividers
  /// between [ListTile]s, and dividers between rows in [DataTable]s.
  final DividerThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DividerTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
