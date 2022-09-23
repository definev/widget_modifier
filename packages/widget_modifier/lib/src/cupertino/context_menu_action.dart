import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/cupertino.dart';

class CupertinoContextMenuActionModifier extends SingleChildStatelessModifier {
  const CupertinoContextMenuActionModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    this.trailingIcon,
  });

  final bool isDefaultAction;
  final bool isDestructiveAction;
  final VoidCallback? onPressed;
  final IconData? trailingIcon;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoContextMenuAction(
      key: modifierKey,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      onPressed: onPressed,
      trailingIcon: trailingIcon,
      child: child!,
    );
  }
}
