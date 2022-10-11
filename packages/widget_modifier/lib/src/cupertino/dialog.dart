import 'package:flutter/cupertino.dart';

import '../modifier.dart';

/// Rounded rectangle surface that looks like an iOS popup surface, e.g., alert dialog
/// and action sheet.
///
/// A [CupertinoPopupSurface] can be configured to paint or not paint a white
/// color on top of its blurred area. Typical usage should paint white on top
/// of the blur. However, the white paint can be disabled for the purpose of
/// rendering divider gaps for a more complicated layout, e.g., [CupertinoAlertDialog].
/// Additionally, the white paint can be disabled to render a blurred rounded
/// rectangle without any color (similar to iOS's volume control popup).
///
/// See also:
///
///  * [CupertinoAlertDialog], which is a dialog with a title, content, and
///    actions.
///  * <https://developer.apple.com/ios/human-interface-guidelines/views/alerts/>
class CupertinoPopupSurfaceModifier extends SingleChildStatelessModifier {
  /// Creates an iOS-style rounded rectangle popup surface.
  const CupertinoPopupSurfaceModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.isSurfacePainted = true,
  });

  /// Whether or not to paint a translucent white on top of this surface's
  /// blurred background. [isSurfacePainted] should be true for a typical popup
  /// that contains content without any dividers. A popup that requires dividers
  /// should set [isSurfacePainted] to false and then paint its own surface area.
  ///
  /// Some popups, like iOS's volume control popup, choose to render a blurred
  /// area without any white paint covering it. To achieve this effect,
  /// [isSurfacePainted] should be set to false.
  final bool isSurfacePainted;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoPopupSurface(
      key: modifierKey,
      isSurfacePainted: isSurfacePainted,
      child: child,
    );
  }
}

/// A button typically used in a [CupertinoActionSheet].
///
/// See also:
///
///  * [CupertinoActionSheet], an alert that presents the user with a set of two or
///    more choices related to the current context.
class CupertinoActionSheetActionModifier extends SingleChildStatelessModifier {
  /// Creates an action for an iOS-style action sheet.
  ///
  /// The [child] and [onPressed] arguments must not be null.
  const CupertinoActionSheetActionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });

  /// The callback that is called when the button is tapped.
  ///
  /// This attribute must not be null.
  final VoidCallback onPressed;

  /// Whether this action is the default choice in the action sheet.
  ///
  /// Default buttons have bold text.
  final bool isDefaultAction;

  /// Whether this action might change or delete data.
  ///
  /// Destructive buttons have red text.
  final bool isDestructiveAction;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoActionSheetAction(
      key: modifierKey,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      onPressed: onPressed,
      child: child!,
    );
  }
}

/// A button typically used in a [CupertinoAlertDialog].
///
/// See also:
///
///  * [CupertinoAlertDialog], a dialog that informs the user about situations
///    that require acknowledgement.
class CupertinoDialogActionModifier extends SingleChildStatelessModifier {
  /// Creates an action for an iOS-style dialog.
  const CupertinoDialogActionModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.textStyle,
  });

  /// The callback that is called when the button is tapped or otherwise
  /// activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onPressed;

  /// Set to true if button is the default choice in the dialog.
  ///
  /// Default buttons have bold text. Similar to
  /// [UIAlertController.preferredAction](https://developer.apple.com/documentation/uikit/uialertcontroller/1620102-preferredaction),
  /// but more than one action can have this attribute set to true in the same
  /// [CupertinoAlertDialog].
  ///
  /// This parameters defaults to false and cannot be null.
  final bool isDefaultAction;
  
  /// Whether this action destroys an object.
  ///
  /// For example, an action that deletes an email is destructive.
  ///
  /// Defaults to false and cannot be null.
  final bool isDestructiveAction;
  
  /// [TextStyle] to apply to any text that appears in this button.
  ///
  /// Dialog actions have a built-in text resizing policy for long text. To
  /// ensure that this resizing policy always works as expected, [textStyle]
  /// must be used if a text size is desired other than that specified in
  /// [_kCupertinoDialogActionStyle].
  final TextStyle? textStyle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoDialogAction(
      key: modifierKey,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      onPressed: onPressed,
      textStyle: textStyle,
      child: child!,
    );
  }
}
