import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines visual properties for [NavigationBar]s and
/// [NavigationDestination]s in this widget's subtree.
///
/// Values specified here are used for [NavigationBar] properties that are not
/// given an explicit non-null value.
///
/// See also:
///
///  * [ThemeData.navigationBarTheme], which describes the
///    [NavigationBarThemeData] in the overall theme for the application.
class NavigationBarThemeModifier extends SingleChildStatelessModifier {
  /// Creates a navigation rail theme that controls the
  /// [NavigationBarThemeData] properties for a [NavigationBar].
  ///
  /// The data argument must not be null.
  const NavigationBarThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Specifies the background color, label text style, icon theme, and label
  /// type values for descendant [NavigationBar] widgets.
  final NavigationBarThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return NavigationBarTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
