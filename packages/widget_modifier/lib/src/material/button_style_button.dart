import 'package:flutter/material.dart';

import '../modifier.dart';

/// The base [StatefulWidget] class for buttons whose style is defined by a [ButtonStyle] object.
///
/// Concrete subclasses must override [defaultStyleOf] and [themeStyleOf].
///
/// See also:
///
///  * [TextButton], a simple ButtonStyleButton without a shadow.
///  * [ElevatedButton], a filled ButtonStyleButton whose material elevates when pressed.
///  * [OutlinedButton], similar to [TextButton], but with an outline.
abstract class ButtonStyleButtonModifier extends SingleChildStatelessModifier {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const ButtonStyleButtonModifier({
    super.key,
    super.modifierKey,
    super.child,
    required this.onPressed,
    required this.onLongPress,
    required this.onHover,
    required this.onFocusChange,
    required this.style,
    required this.focusNode,
    required this.autofocus,
    required this.clipBehavior,
    this.statesController,
  });

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
}
