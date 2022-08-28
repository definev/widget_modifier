import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DefaultTextEditingShortcutsModifier extends SingleChildStatelessWidget {
  const DefaultTextEditingShortcutsModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
  }) : super(key: key);

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTextEditingShortcuts(
      key: modifierKey,
      child: child!,
    );
  }
}
