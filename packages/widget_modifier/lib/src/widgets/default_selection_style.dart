import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// The selection style to apply to descendant [EditableText] widgets which
/// don't have an explicit style.
///
/// {@macro flutter.cupertino.CupertinoApp.defaultSelectionStyle}
///
/// {@macro flutter.material.MaterialApp.defaultSelectionStyle}
///
/// See also:
///  * [TextSelectionTheme]: which also creates a [DefaultSelectionStyle] for
///    the subtree.
class DefaultSelectionStyleModifier extends SingleChildStatelessModifier {
  /// Creates a default selection style widget that specifies the selection
  /// properties for all widgets below it in the widget tree.
  const DefaultSelectionStyleModifier({
    super.key,
    super.modifierKey,
    this.cursorColor,
    this.selectionColor,
    super.child,
  });

  /// A const-constructable default selection style that provides fallback
  /// values.
  ///
  /// Returned from [of] when the given [BuildContext] doesn't have an enclosing
  /// default selection style.
  ///
  /// This constructor creates a [DefaultTextStyle] with an invalid [child],
  /// which means the constructed value cannot be incorporated into the tree.
  const DefaultSelectionStyleModifier.fallback({
    super.key,
    super.child,
    super.modifierKey,
  })  : cursorColor = null,
        selectionColor = null;

  /// The color of the text field's cursor.
  ///
  /// The cursor indicates the current location of the text insertion point in
  /// the field.
  final Color? cursorColor;

  /// The background color of selected text.
  final Color? selectionColor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultSelectionStyle(
      key: modifierKey,
      cursorColor: cursorColor,
      selectionColor: selectionColor,
      child: child!,
    );
  }
}
