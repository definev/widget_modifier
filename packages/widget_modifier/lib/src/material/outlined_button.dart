import 'package:flutter/material.dart';

import '../modifier.dart';

/// A Material Design "Outlined Button"; essentially a [TextButton]
/// with an outlined border.
///
/// Outlined buttons are medium-emphasis buttons. They contain actions
/// that are important, but they aren’t the primary action in an app.
///
/// An outlined button is a label [child] displayed on a (zero
/// elevation) [Material] widget. The label's [Text] and [Icon]
/// widgets are displayed in the [style]'s
/// [ButtonStyle.foregroundColor] and the outline's weight and color
/// are defined by [ButtonStyle.side].  The button reacts to touches
/// by filling with the [style]'s [ButtonStyle.overlayColor].
///
/// The outlined button's default style is defined by [defaultStyleOf].
/// The style of this outline button can be overridden with its [style]
/// parameter. The style of all text buttons in a subtree can be
/// overridden with the [OutlinedButtonTheme] and the style of all of the
/// outlined buttons in an app can be overridden with the [Theme]'s
/// [ThemeData.outlinedButtonTheme] property.
///
/// Unlike [TextButton] or [ElevatedButton], outline buttons have a
/// default [ButtonStyle.side] which defines the appearance of the
/// outline.  Because the default `side` is non-null, it
/// unconditionally overrides the shape's [OutlinedBorder.side]. In
/// other words, to specify an outlined button's shape _and_ the
/// appearance of its outline, both the [ButtonStyle.shape] and
/// [ButtonStyle.side] properties must be specified.
///
/// {@tool dartpad}
/// Here is an example of a basic [OutlinedButton].
///
/// ** See code in examples/api/lib/material/outlined_button/outlined_button.0.dart **
/// {@end-tool}
///
/// The static [styleFrom] method is a convenient way to create a
/// outlined button [ButtonStyle] from simple values.
///
/// See also:
///
///  * [ElevatedButton], a filled Material Design button with a shadow.
///  * [TextButton], a Material Design button without a shadow.
///  * <https://material.io/design/components/buttons.html>
///  * <https://m3.material.io/components/buttons>
class OutlinedButtonModifier extends SingleChildStatelessModifier {
  /// Create an OutlinedButton.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  const OutlinedButtonModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
  });

  
  /// Create a text button from a pair of widgets that serve as the button's
  /// [icon] and [label].
  ///
  /// The icon and label are arranged in a row and padded by 12 logical pixels
  /// at the start, and 16 at the end, with an 8 pixel gap in between.
  ///
  /// The [icon] and [label] arguments must not be null.
  static SingleChildModifier icon({
    Key? key,
    Key? modifierKey,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) =>
      _OutlinedButtonWithIcon(
        autofocus: autofocus,
        key: key,
        modifierKey: modifierKey,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        onLongPress: onLongPress,
        style: style,
        onPressed: onPressed,
        icon: icon,
        label: label,
      );

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  ///
  /// If this callback and [onPressed] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback? onLongPress;

  /// Called when a pointer enters or exits the button response area.
  ///
  /// The value passed to the callback is true if a pointer has entered this
  /// part of the material and false if a pointer has exited this part of the
  /// material.
  final ValueChanged<bool>? onHover;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// Customizes this button's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [themeStyleOf] and [defaultStyleOf]. [MaterialStateProperty]s
  /// that resolve to non-null values will similarly override the corresponding
  /// [MaterialStateProperty]s in [themeStyleOf] and [defaultStyleOf].
  ///
  /// Null by default.
  final ButtonStyle? style;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.material.inkwell.statesController}
  final MaterialStatesController? statesController;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OutlinedButton(
      key: modifierKey,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      statesController: statesController,
      style: style,
      onPressed: onPressed,
      child: child!,
    );
  }
}

class _OutlinedButtonWithIcon extends SingleChildStatelessModifier {
  const _OutlinedButtonWithIcon({
    super.key,
    super.modifierKey,
    required this.onPressed,
    this.onLongPress,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
    required this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final Widget icon;
  final Widget label;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return OutlinedButton.icon(
      key: modifierKey,
      onPressed: onPressed,
      icon: icon,
      label: label,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onLongPress: onLongPress,
      style: style,
    );
  }
}
