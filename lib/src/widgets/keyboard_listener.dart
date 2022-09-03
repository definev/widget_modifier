import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class KeyboardListenerModifier extends SingleChildStatelessModifier {
  const KeyboardListenerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.focusNode,
    this.autofocus = false,
    this.includeSemantics = true,
    this.onKeyEvent,
  }) : super(key: modifierKey, child: child);

  final FocusNode focusNode;
  final bool autofocus;
  final bool includeSemantics;
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
