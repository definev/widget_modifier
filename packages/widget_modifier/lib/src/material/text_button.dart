import 'package:flutter/material.dart';

import '../modifier.dart';
import 'button_style_button.dart';

/// A Material Design "Text Button".
///
/// Use text buttons on toolbars, in dialogs, or inline with other
/// content but offset from that content with padding so that the
/// button's presence is obvious. Text buttons do not have visible
/// borders and must therefore rely on their position relative to
/// other content for context. In dialogs and cards, they should be
/// grouped together in one of the bottom corners. Avoid using text
/// buttons where they would blend in with other content, for example
/// in the middle of lists.
///
/// A text button is a label [child] displayed on a (zero elevation)
/// [Material] widget. The label's [Text] and [Icon] widgets are
/// displayed in the [style]'s [ButtonStyle.foregroundColor]. The
/// button reacts to touches by filling with the [style]'s
/// [ButtonStyle.backgroundColor].
///
/// The text button's default style is defined by [defaultStyleOf].
/// The style of this text button can be overridden with its [style]
/// parameter. The style of all text buttons in a subtree can be
/// overridden with the [TextButtonTheme] and the style of all of the
/// text buttons in an app can be overridden with the [Theme]'s
/// [ThemeData.textButtonTheme] property.
///
/// The static [styleFrom] method is a convenient way to create a
/// text button [ButtonStyle] from simple values.
///
/// If the [onPressed] and [onLongPress] callbacks are null, then this
/// button will be disabled, it will not react to touch.
///
/// {@tool dartpad}
/// This sample shows how to render a disabled TextButton, an enabled TextButton
/// and lastly a TextButton with gradient background.
///
/// ** See code in examples/api/lib/material/text_button/text_button.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This sample demonstrates using the [statesController] parameter to create a button
/// that adds support for [MaterialState.selected].
///
/// ** See code in examples/api/lib/material/text_button/text_button.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [OutlinedButton], a [TextButton] with a border outline.
///  * [ElevatedButton], a filled button whose material elevates when pressed.
///  * <https://material.io/design/components/buttons.html>
///  * <https://m3.material.io/components/buttons>
class TextButtonModifier extends ButtonStyleButtonModifier {
  /// Create a TextButton.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  const TextButtonModifier({
    super.key,
    super.child,
    super.modifierKey,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.clipBehavior = Clip.none,
    super.statesController,
  });

  
  /// Create a text button from a pair of widgets that serve as the button's
  /// [icon] and [label].
  ///
  /// The icon and label are arranged in a row and padded by 8 logical pixels
  /// at the ends, with an 8 pixel gap in between.
  ///
  /// The [icon] and [label] arguments must not be null.
  static SingleChildModifier icon({
    Key? key,
    Key? modifierKey,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) =>
      _TextButtonWithIcon(
        key: key,
        modifierKey: modifierKey,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        onHover: onHover,
        onLongPress: onLongPress,
        style: style,
        icon: icon,
        label: label,
        onPressed: onPressed,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
      );

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextButton(
      key: modifierKey,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      statesController: statesController,
      style: style,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onPressed: onPressed,
      child: child!,
    );
  }
}

class _TextButtonWithIcon extends SingleChildStatelessModifier {
  const _TextButtonWithIcon({
    super.key,
    super.modifierKey,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    required this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final Clip? clipBehavior;
  final bool? autofocus;
  final Widget icon;
  final Widget label;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextButton.icon(
      key: modifierKey,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      style: style,
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }
}
