import 'package:flutter/material.dart';

import '../modifier.dart';

/// Overrides the visibility of descendant [Tooltip] widgets.
///
/// If disabled, the descendant [Tooltip] widgets will not display a tooltip
/// when tapped, long-pressed, hovered by the mouse, or when
/// `ensureTooltipVisible` is called. This only visually disables tooltips but
/// continues to provide any semantic information that is provided.
class TooltipVisibilityModifier extends SingleChildStatelessModifier {
  /// Creates a widget that configures the visibility of [Tooltip].
  ///
  /// Both arguments must not be null.
  const TooltipVisibilityModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.visible,
  });

  /// Determines the visibility of [Tooltip] widgets that inherit from this widget.
  final bool visible;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TooltipVisibility(
      key: modifierKey,
      visible: visible,
      child: child!,
    );
  }
}
