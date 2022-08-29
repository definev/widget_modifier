import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class RawKeyboardListenerModifier extends SingleChildStatelessWidget {
  const RawKeyboardListenerModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.focusNode,
    this.autofocus = false,
    this.includeSemantics = true,
    this.onKey,
  })  : assert(child != null),
        super(key: key, child: child);

  final Key? modifierKey;
  final FocusNode focusNode;
  final bool autofocus;
  final bool includeSemantics;
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
