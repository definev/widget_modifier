import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Controls the default color, opacity, and size of icons in a widget subtree.
///
/// The icon theme is honored by [Icon] and [ImageIcon] widgets.
class IconThemeModifier extends SingleChildStatelessModifier {
  /// Creates an icon theme that controls the color, opacity, and size of
  /// descendant widgets.
  ///˚
  /// Both [data] and [child] arguments must not be null.
  const IconThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The color, opacity, and size to use for icons in this subtree.
  final IconThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IconTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
