import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines visual properties for [NavigationRail]s and
/// [NavigationRailDestination]s in this widget's subtree.
///
/// Values specified here are used for [NavigationRail] properties that are not
/// given an explicit non-null value.
class NavigationRailThemeModifier extends SingleChildStatelessModifier {
  /// Creates a navigation rail theme that controls the
  /// [NavigationRailThemeData] properties for a [NavigationRail].
  ///
  /// The data argument must not be null.
  const NavigationRailThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Specifies the background color, elevation, label text style, icon theme,
  /// group alignment, and label type and border values for descendant
  /// [NavigationRail] widgets.
  final NavigationRailThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return NavigationRailTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
