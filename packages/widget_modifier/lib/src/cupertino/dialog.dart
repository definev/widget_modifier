import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/cupertino.dart';

class CupertinoPopupSurfaceModifier extends SingleChildStatelessModifier {
  const CupertinoPopupSurfaceModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.isSurfacePainted = true,
  });

  final bool isSurfacePainted;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoPopupSurface(
      key: modifierKey,
      isSurfacePainted: isSurfacePainted,
      child: child,
    );
  }
}

class CupertinoActionSheetActionModifier extends SingleChildStatelessModifier {
  const CupertinoActionSheetActionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });

  final VoidCallback onPressed;
  final bool isDefaultAction;
  final bool isDestructiveAction;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoActionSheetAction(
      key: modifierKey,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      onPressed: onPressed,
      child: child!,
    );
  }
}

class CupertinoDialogActionModifier extends SingleChildStatelessModifier {
  const CupertinoDialogActionModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.textStyle,
  });

  final VoidCallback? onPressed;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final TextStyle? textStyle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoDialogAction(
      key: modifierKey,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      onPressed: onPressed,
      textStyle: textStyle,
      child: child!,
    );
  }
}
