import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DefaultSelectionStyleModifier extends SingleChildStatelessWidget {
  const DefaultSelectionStyleModifier({
    super.key,
    this.modifierKey,
    this.cursorColor,
    this.selectionColor,
    super.child,
  });

  const DefaultSelectionStyleModifier.fallback({
    super.key,
    super.child,
    this.modifierKey,
  })  : cursorColor = null,
        selectionColor = null;

  final Key? modifierKey;
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
