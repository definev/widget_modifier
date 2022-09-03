import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class SelectionAreaModifier extends SingleChildStatelessWidget {
  const SelectionAreaModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.focusNode,
    this.selectionControls,
  });

  final Key? modifierKey;
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
