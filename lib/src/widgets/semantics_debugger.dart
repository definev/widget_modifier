import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class SemanticsDebuggerModifier extends SingleChildStatelessModifier {
  const SemanticsDebuggerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.labelStyle = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 10.0,
      height: 0.8,
    ),
  }) : super(key: key, child: child);

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
