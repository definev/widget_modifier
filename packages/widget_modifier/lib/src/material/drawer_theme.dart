import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines visual properties for [Drawer]s in this
/// widget's subtree.
///
/// Values specified here are used for [Drawer] properties that are not
/// given an explicit non-null value.
///
/// Using this would allow you to override the [ThemeData.drawerTheme].
class DrawerThemeModifier extends SingleChildStatelessModifier {
  /// Creates a theme that defines the [DrawerThemeData] properties for a
  /// [Drawer].
  const DrawerThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Specifies the background color, scrim color, elevation, and shape for
  /// descendant [Drawer] widgets.
  final DrawerThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DrawerTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
