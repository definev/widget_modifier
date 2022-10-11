import 'package:flutter/cupertino.dart';

import '../modifier.dart';

/// A button in a _ContextMenuSheet.
///
/// A typical use case is to pass a [Text] as the [child] here, but be sure to
/// use [TextOverflow.ellipsis] for the [Text.overflow] field if the text may be
/// long, as without it the text will wrap to the next line.
class CupertinoContextMenuActionModifier extends SingleChildStatelessModifier {
  /// Construct a CupertinoContextMenuAction.
  const CupertinoContextMenuActionModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    this.trailingIcon,
  });

  /// Indicates whether this action should receive the style of an emphasized,
  /// default action.
  final bool isDefaultAction;

  /// Indicates whether this action should receive the style of a destructive
  /// action.
  final bool isDestructiveAction;

  /// Called when the action is pressed.
  final VoidCallback? onPressed;
  
  /// An optional icon to display to the right of the child.
  ///
  /// Will be colored in the same way as the [TextStyle] used for [child] (for
  /// example, if using [isDestructiveAction]).
  final IconData? trailingIcon;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoContextMenuAction(
      key: modifierKey,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      onPressed: onPressed,
      trailingIcon: trailingIcon,
      child: child!,
    );
  }
}
