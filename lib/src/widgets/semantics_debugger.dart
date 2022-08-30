import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class SemanticsDebuggerModifier extends SingleChildStatelessWidget {
  const SemanticsDebuggerModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.labelStyle = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 10.0,
      height: 0.8,
    ),
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final TextStyle labelStyle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SemanticsDebugger(
      key: modifierKey,
      labelStyle: labelStyle,
      child: child!,
    );
  }
}
