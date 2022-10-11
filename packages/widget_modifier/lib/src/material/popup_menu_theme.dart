import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines the configuration for
/// popup menus in this widget's subtree.
///
/// Values specified here are used for popup menu properties that are not
/// given an explicit non-null value.
class PopupMenuThemeModifier extends SingleChildStatelessModifier {
  /// Creates a popup menu theme that controls the configurations for
  /// popup menus in its widget subtree.
  ///
  /// The data argument must not be null.
  const PopupMenuThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties for descendant popup menu widgets.
  final PopupMenuThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PopupMenuTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
