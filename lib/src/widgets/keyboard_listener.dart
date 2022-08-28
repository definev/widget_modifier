import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class KeyboardListenerModifier extends SingleChildStatelessWidget {
  const KeyboardListenerModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.focusNode,
    this.autofocus = false,
    this.includeSemantics = true,
    this.onKeyEvent,
  }) : super(key: modifierKey, child: child);

  final Key? modifierKey;
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
