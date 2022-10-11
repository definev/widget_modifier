import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that calls a callback whenever the user presses or releases a key
/// on a keyboard.
///
/// A [KeyboardListener] is useful for listening to key events and
/// hardware buttons that are represented as keys. Typically used by games and
/// other apps that use keyboards for purposes other than text entry.
///
/// For text entry, consider using a [EditableText], which integrates with
/// on-screen keyboards and input method editors (IMEs).
///
/// The [KeyboardListener] is different from [RawKeyboardListener] in that
/// [KeyboardListener] uses the newer [HardwareKeyboard] API, which is
/// preferable.
///
/// See also:
///
///  * [EditableText], which should be used instead of this widget for text
///    entry.
///  * [RawKeyboardListener], a similar widget based on the old [RawKeyboard]
///    API.
class KeyboardListenerModifier extends SingleChildStatelessModifier {
  /// Creates a widget that receives  keyboard events.
  ///
  /// For text entry, consider using a [EditableText], which integrates with
  /// on-screen keyboards and input method editors (IMEs).
  ///
  /// The [focusNode] and [child] arguments are required and must not be null.
  ///
  /// The [autofocus] argument must not be null.
  ///
  /// The `key` is an identifier for widgets, and is unrelated to keyboards.
  /// See [Widget.key].
  const KeyboardListenerModifier({
    super.child,
    super.modifierKey,
    required this.focusNode,
    this.autofocus = false,
    this.includeSemantics = true,
    this.onKeyEvent,
  }) : super(key: modifierKey);

  /// Controls whether this widget has keyboard focus.
  final FocusNode focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.includeSemantics}
  final bool includeSemantics;

  /// Called whenever this widget receives a keyboard event.
  final ValueChanged<KeyEvent>? onKeyEvent;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return KeyboardListener(
      key: modifierKey,
      focusNode: focusNode,
      autofocus: autofocus,
      includeSemantics: includeSemantics,
      onKeyEvent: onKeyEvent,
      child: child!,
    );
  }
}
