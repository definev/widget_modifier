import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class ReorderableDragStartListenerModifier extends SingleChildStatelessWidget {
  const ReorderableDragStartListenerModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.index,
    this.enabled = true,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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

class ReorderableDelayedDragStartListenerModifier
    extends SingleChildStatelessWidget {
  const ReorderableDelayedDragStartListenerModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.index,
    this.enabled = true,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
