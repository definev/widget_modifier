import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A wrapper widget that will recognize the start of a drag on the wrapped
/// widget by a [PointerDownEvent], and immediately initiate dragging the
/// wrapped item to a new location in a reorderable list.
///
/// See also:
///
///  * [ReorderableDelayedDragStartListener], a similar wrapper that will
///    only recognize the start after a long press event.
///  * [ReorderableList], a widget list that allows the user to reorder
///    its items.
///  * [SliverReorderableList], a sliver list that allows the user to reorder
///    its items.
///  * [ReorderableListView], a Material Design list that allows the user to
///    reorder its items.
class ReorderableDragStartListenerModifier extends SingleChildStatelessModifier {
  /// Creates a listener for a drag immediately following a pointer down
  /// event over the given child widget.
  ///
  /// This is most commonly used to wrap part of a list item like a drag
  /// handle.
  const ReorderableDragStartListenerModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.index,
    this.enabled = true,
  });

  /// The index of the associated item that will be dragged in the list.
  final int index;

  /// Whether the [child] item can be dragged and moved in the list.
  ///
  /// If true, the item can be moved to another location in the list when the
  /// user taps on the child. If false, tapping on the child will be ignored.
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


/// A wrapper widget that will recognize the start of a drag operation by
/// looking for a long press event. Once it is recognized, it will start
/// a drag operation on the wrapped item in the reorderable list.
///
/// See also:
///
///  * [ReorderableDragStartListener], a similar wrapper that will
///    recognize the start of the drag immediately after a pointer down event.
///  * [ReorderableList], a widget list that allows the user to reorder
///    its items.
///  * [SliverReorderableList], a sliver list that allows the user to reorder
///    its items.
///  * [ReorderableListView], a Material Design list that allows the user to
///    reorder its items.
class ReorderableDelayedDragStartListenerModifier extends SingleChildStatelessModifier {
  /// Creates a listener for an drag following a long press event over the
  /// given child widget.
  ///
  /// This is most commonly used to wrap an entire list item in a reorderable
  /// list.
  const ReorderableDelayedDragStartListenerModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.index,
    this.enabled = true,
  });

  /// The index of the associated item that will be dragged in the list.
  final int index;

  /// Whether the [child] item can be dragged and moved in the list.
  ///
  /// If true, the item can be moved to another location in the list when the
  /// user taps on the child. If false, tapping on the child will be ignored.
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
