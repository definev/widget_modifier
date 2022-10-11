import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines the configuration for
/// [Tooltip]s in this widget's subtree.
///
/// Values specified here are used for [Tooltip] properties that are not
/// given an explicit non-null value.
///
/// {@tool snippet}
///
/// Here is an example of a tooltip theme that applies a blue foreground
/// with non-rounded corners.
///
/// ```dart
/// TooltipTheme(
///   data: TooltipThemeData(
///     decoration: BoxDecoration(
///       color: Colors.blue.withOpacity(0.9),
///       borderRadius: BorderRadius.zero,
///     ),
///   ),
///   child: Tooltip(
///     message: 'Example tooltip',
///     child: IconButton(
///       iconSize: 36.0,
///       icon: const Icon(Icons.touch_app),
///       onPressed: () {},
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [TooltipVisibility], which can be used to visually disable descendant [Tooltip]s.
class TooltipThemeModifier extends SingleChildStatelessModifier {
  /// Creates a tooltip theme that controls the configurations for
  /// [Tooltip].
  ///
  /// The data argument must not be null.
  const TooltipThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties for descendant [Tooltip] widgets.
  final TooltipThemeData data;
  
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TooltipTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
