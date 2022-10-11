import 'package:flutter/material.dart';

import '../modifier.dart';

/// A button styled like a Material native Android text selection menu button.
class TextSelectionToolbarTextButtonModifier extends SingleChildStatelessModifier {
  /// Creates an instance of TextSelectionToolbarTextButton.
  const TextSelectionToolbarTextButtonModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.padding,
    this.onPressed,
  });
  
  /// {@template flutter.material.TextSelectionToolbarTextButton.onPressed}
  /// Called when this button is pressed.
  /// {@endtemplate}
  final VoidCallback? onPressed;

  /// The padding between the button's edge and its child.
  ///
  /// In a standard Material [TextSelectionToolbar], the padding depends on the
  /// button's position within the toolbar.
  ///
  /// See also:
  ///
  ///  * [getPadding], which calculates the standard padding based on the
  ///    button's position.
  ///  * [ButtonStyle.padding], which is where this padding is applied.
  final EdgeInsets padding;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextSelectionToolbarTextButton(
      key: modifierKey,
      onPressed: onPressed,
      padding: padding,
      child: child!,
    );
  }
}
