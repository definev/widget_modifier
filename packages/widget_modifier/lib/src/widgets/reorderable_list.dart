import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class ReorderableDragStartListenerModifier extends SingleChildStatelessModifier {
  const ReorderableDragStartListenerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.index,
    this.enabled = true,
  }) : super(key: key, child: child);

  final int index;
  final bool enabled;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ReorderableDragStartListener(
      key: modifierKey,
      index: index,
      enabled: enabled,
      child: child!,
    );
  }
}

class ReorderableDelayedDragStartListenerModifier extends SingleChildStatelessModifier {
  const ReorderableDelayedDragStartListenerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.index,
    this.enabled = true,
  }) : super(key: key, child: child);

  final int index;
  final bool enabled;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ReorderableDelayedDragStartListener(
      key: modifierKey,
      index: index,
      enabled: enabled,
      child: child!,
    );
  }
}
