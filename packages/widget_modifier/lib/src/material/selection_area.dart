import 'package:flutter/material.dart';

import '../modifier.dart';

/// A widget that introduces an area for user selections with adaptive selection
/// controls.
///
/// This widget creates a [SelectableRegion] with platform-adaptive selection
/// controls.
///
/// Flutter widgets are not selectable by default. To enable selection for
/// a specific screen, consider wrapping the body of the [Route] with a
/// [SelectionArea].
///
/// {@tool dartpad}
/// This example shows how to make a screen selectable.
///
/// ** See code in examples/api/lib/material/selection_area/selection_area.dart **
/// {@end-tool}
///
/// See also:
///  * [SelectableRegion], which provides an overview of the selection system.
class SelectionAreaModifier extends SingleChildStatelessModifier {
  /// Creates a [SelectionArea].
  ///
  /// If [selectionControls] is null, a platform specific one is used.
  const SelectionAreaModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.focusNode,
    this.selectionControls,
  });

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The delegate to build the selection handles and toolbar.
  ///
  /// If it is null, the platform specific selection control is used.
  final TextSelectionControls? selectionControls;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SelectionArea(
      key: modifierKey,
      focusNode: focusNode,
      selectionControls: selectionControls,
      child: child!,
    );
  }
}
