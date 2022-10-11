import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that calls a callback whenever the user presses or releases a key
/// on a keyboard.
///
/// A [RawKeyboardListener] is useful for listening to raw key events and
/// hardware buttons that are represented as keys. Typically used by games and
/// other apps that use keyboards for purposes other than text entry.
///
/// For text entry, consider using a [EditableText], which integrates with
/// on-screen keyboards and input method editors (IMEs).
///
/// The [RawKeyboardListener] is different from [KeyboardListener] in that
/// [RawKeyboardListener] uses the legacy [RawKeyboard] API. Use
/// [KeyboardListener] if possible.
///
/// See also:
///
///  * [EditableText], which should be used instead of this widget for text
///    entry.
///  * [KeyboardListener], a similar widget based on the newer
///    [HardwareKeyboard] API.
class RawKeyboardListenerModifier extends SingleChildStatelessModifier {
  /// Creates a widget that receives raw keyboard events.
  ///
  /// For text entry, consider using a [EditableText], which integrates with
  /// on-screen keyboards and input method editors (IMEs).
  ///
  /// The [focusNode] and [child] arguments are required and must not be null.
  ///
  /// The [autofocus] argument must not be null.
  const RawKeyboardListenerModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.focusNode,
    this.autofocus = false,
    this.includeSemantics = true,
    this.onKey,
  });
  
  /// Controls whether this widget has keyboard focus.
  final FocusNode focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.Focus.includeSemantics}
  final bool includeSemantics;

  /// Called whenever this widget receives a raw keyboard event.
  final ValueChanged<RawKeyEvent>? onKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RawKeyboardListener(
      key: modifierKey,
      focusNode: focusNode,
      autofocus: autofocus,
      includeSemantics: includeSemantics,
      onKey: onKey,
      child: child!,
    );
  }
}
