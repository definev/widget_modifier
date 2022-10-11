import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that describes this app in the operating system.
class TitleModifier extends SingleChildStatelessModifier {
  /// Creates a widget that describes this app to the Android operating system.
  ///
  /// [title] will default to the empty string if not supplied.
  /// [color] must be an opaque color (i.e. color.alpha must be 255 (0xFF)).
  /// [color] and [child] are required arguments.
  const TitleModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.title = '',
    required this.color,
  });

  /// A one-line description of this app for use in the window manager.
  /// Must not be null.
  final String title;

  /// A color that the window manager should use to identify this app. Must be
  /// an opaque color (i.e. color.alpha must be 255 (0xFF)), and must not be
  /// null.
  final Color color;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Title(
      key: modifierKey,
      color: color,
      title: title,
      child: child!,
    );
  }
}
