import 'package:flutter/cupertino.dart';

import '../modifier.dart';

/// Applies a visual styling theme to descendant Cupertino widgets.
///
/// Affects the color and text styles of Cupertino widgets whose styling
/// are not overridden when constructing the respective widgets instances.
///
/// Descendant widgets can retrieve the current [CupertinoThemeData] by calling
/// [CupertinoTheme.of]. An [InheritedWidget] dependency is created when
/// an ancestor [CupertinoThemeData] is retrieved via [CupertinoTheme.of].
///
/// The [CupertinoTheme] widget implies an [IconTheme] widget, whose
/// [IconTheme.data] has the same color as [CupertinoThemeData.primaryColor]
///
/// See also:
///
///  * [CupertinoThemeData], specifies the theme's visual styling.
///  * [CupertinoApp], which will automatically add a [CupertinoTheme] based on the
///    value of [CupertinoApp.theme].
///  * [Theme], a Material theme which will automatically add a [CupertinoTheme]
///    with a [CupertinoThemeData] derived from the Material [ThemeData].
class CupertinoThemeModifier extends SingleChildStatelessModifier {
  /// Creates a [CupertinoTheme] to change descendant Cupertino widgets' styling.
  ///
  /// The [data] and [child] parameters must not be null.
  const CupertinoThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The [CupertinoThemeData] styling for this theme.
  final CupertinoThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
