import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class RawKeyboardListenerModifier extends SingleChildStatelessModifier {
  const RawKeyboardListenerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.focusNode,
    this.autofocus = false,
    this.includeSemantics = true,
    this.onKey,
  })  : assert(child != null),
        super(key: key, child: child);

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
