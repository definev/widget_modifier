import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/cupertino.dart';

class CupertinoContextMenuModifier extends SingleChildStatelessModifier {
  const CupertinoContextMenuModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.actions,
    this.previewBuilder,
  });

  final List<Widget> actions;
  final ContextMenuPreviewBuilder? previewBuilder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoContextMenu(
      key: modifierKey,
      actions: actions,
      previewBuilder: previewBuilder,
      child: child!,
    );
  }
}
