import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class SelectionAreaModifier extends SingleChildStatelessModifier {
  const SelectionAreaModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.focusNode,
    this.selectionControls,
  });

  final FocusNode? focusNode;
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
