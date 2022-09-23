import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class DefaultSelectionStyleModifier extends SingleChildStatelessModifier {
  const DefaultSelectionStyleModifier({
    super.key,
    super.modifierKey,
    this.cursorColor,
    this.selectionColor,
    super.child,
  });

  const DefaultSelectionStyleModifier.fallback({
    super.key,
    super.child,
    super.modifierKey,
  })  : cursorColor = null,
        selectionColor = null;

  final Color? cursorColor;
  final Color? selectionColor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultSelectionStyle(
      key: modifierKey,
      cursorColor: cursorColor,
      selectionColor: selectionColor,
      child: child!,
    );
  }
}
