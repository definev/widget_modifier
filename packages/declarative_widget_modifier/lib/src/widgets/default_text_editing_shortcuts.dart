import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class DefaultTextEditingShortcutsModifier extends SingleChildStatelessModifier {
  const DefaultTextEditingShortcutsModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
  }) : super(key: key);

  @override
  

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTextEditingShortcuts(
      key: modifierKey,
      child: child!,
    );
  }
}
