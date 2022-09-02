// ignore_for_file: deprecated_member_use_from_same_package, deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DraggableModifier<T extends Object> extends SingleChildStatelessWidget {
  const DraggableModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.feedback,
    this.data,
    this.axis,
    this.childWhenDragging,
    this.feedbackOffset = Offset.zero,
    @Deprecated(
      'Use dragAnchorStrategy instead. '
      'Replace "dragAnchor: DragAnchor.child" with "dragAnchorStrategy: childDragAnchorStrategy". '
      'Replace "dragAnchor: DragAnchor.pointer" with "dragAnchorStrategy: pointerDragAnchorStrategy". '
      'This feature was deprecated after v2.1.0-10.0.pre.',
    )
        this.dragAnchor = DragAnchor.child,
    this.dragAnchorStrategy,
    this.affinity,
    this.maxSimultaneousDrags,
    this.onDragStarted,
    this.onDragUpdate,
    this.onDraggableCanceled,
    this.onDragEnd,
    this.onDragCompleted,
    this.ignoringFeedbackSemantics = true,
    this.ignoringFeedbackPointer = true,
    this.rootOverlay = false,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
  });

  final Key? modifierKey;
  final T? data;
  final Axis? axis;
  final Widget? childWhenDragging;
  final Widget feedback;
  final Offset feedbackOffset;
  @Deprecated(
    'Use dragAnchorStrategy instead. '
    'This feature was deprecated after v2.1.0-10.0.pre.',
  )
  final DragAnchor dragAnchor;
  final DragAnchorStrategy? dragAnchorStrategy;
  final bool ignoringFeedbackSemantics;
  final bool ignoringFeedbackPointer;
  final Axis? affinity;
  final int? maxSimultaneousDrags;
  final VoidCallback? onDragStarted;
  final DragUpdateCallback? onDragUpdate;
  final DraggableCanceledCallback? onDraggableCanceled;
  final VoidCallback? onDragCompleted;
  final DragEndCallback? onDragEnd;
  final bool rootOverlay;
  final HitTestBehavior hitTestBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Draggable(
      key: modifierKey,
      affinity: affinity,
      axis: axis,
      childWhenDragging: childWhenDragging,
      data: data,
      dragAnchor: dragAnchor,
      dragAnchorStrategy: dragAnchorStrategy,
      feedbackOffset: feedbackOffset,
      hitTestBehavior: hitTestBehavior,
      ignoringFeedbackPointer: ignoringFeedbackPointer,
      ignoringFeedbackSemantics: ignoringFeedbackSemantics,
      maxSimultaneousDrags: maxSimultaneousDrags,
      onDragCompleted: onDragCompleted,
      onDragEnd: onDragEnd,
      onDragStarted: onDragStarted,
      onDragUpdate: onDragUpdate,
      onDraggableCanceled: onDraggableCanceled,
      rootOverlay: rootOverlay,
      feedback: feedback,
      child: child!,
    );
  }
}

class LongPressDraggableModifier<T extends Object>
    extends SingleChildStatelessWidget {
  const LongPressDraggableModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.feedback,
    this.data,
    this.axis,
    this.childWhenDragging,
    this.feedbackOffset = Offset.zero,
    @Deprecated(
      'Use dragAnchorStrategy instead. '
      'Replace "dragAnchor: DragAnchor.child" with "dragAnchorStrategy: childDragAnchorStrategy". '
      'Replace "dragAnchor: DragAnchor.pointer" with "dragAnchorStrategy: pointerDragAnchorStrategy". '
      'This feature was deprecated after v2.1.0-10.0.pre.',
    )
        this.dragAnchor = DragAnchor.child,
    this.dragAnchorStrategy,
    this.affinity,
    this.maxSimultaneousDrags,
    this.onDragStarted,
    this.onDragUpdate,
    this.onDraggableCanceled,
    this.onDragEnd,
    this.onDragCompleted,
    this.ignoringFeedbackSemantics = true,
    this.ignoringFeedbackPointer = true,
    this.rootOverlay = false,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.hapticFeedbackOnStart = false,
    this.delay = kLongPressTimeout,
  });

  final Key? modifierKey;
  final T? data;
  final Axis? axis;
  final Widget? childWhenDragging;
  final Widget feedback;
  final Offset feedbackOffset;
  @Deprecated(
    'Use dragAnchorStrategy instead. '
    'This feature was deprecated after v2.1.0-10.0.pre.',
  )
  final DragAnchor dragAnchor;
  final DragAnchorStrategy? dragAnchorStrategy;
  final bool ignoringFeedbackSemantics;
  final bool ignoringFeedbackPointer;
  final Axis? affinity;
  final int? maxSimultaneousDrags;
  final VoidCallback? onDragStarted;
  final DragUpdateCallback? onDragUpdate;
  final DraggableCanceledCallback? onDraggableCanceled;
  final VoidCallback? onDragCompleted;
  final DragEndCallback? onDragEnd;
  final bool rootOverlay;
  final HitTestBehavior hitTestBehavior;

  final bool hapticFeedbackOnStart;
  final Duration delay;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return LongPressDraggable<T>(
      key: modifierKey,
      feedback: feedback,
      axis: axis,
      childWhenDragging: childWhenDragging,
      data: data,
      delay: delay,
      dragAnchor: dragAnchor,
      dragAnchorStrategy: dragAnchorStrategy,
      feedbackOffset: feedbackOffset,
      hapticFeedbackOnStart: hapticFeedbackOnStart,
      ignoringFeedbackPointer: ignoringFeedbackPointer,
      ignoringFeedbackSemantics: ignoringFeedbackSemantics,
      maxSimultaneousDrags: maxSimultaneousDrags,
      onDragCompleted: onDragCompleted,
      onDragEnd: onDragEnd,
      onDragStarted: onDragStarted,
      onDragUpdate: onDragUpdate,
      onDraggableCanceled: onDraggableCanceled,
      child: child!,
    );
  }
}

typedef SingleChildDragTargetBuilder<T> = Widget Function(
  BuildContext context,
  List<T?> candidateData,
  List<dynamic> rejectedData,
  Widget? child,
);

class DragTargetModifier<T extends Object> extends SingleChildStatelessWidget {
  const DragTargetModifier({
    super.key,
    super.child,
    this.modifierKey,
    required this.builder,
    this.onWillAccept,
    this.onAccept,
    this.onAcceptWithDetails,
    this.onLeave,
    this.onMove,
    this.hitTestBehavior = HitTestBehavior.translucent,
  });

  final Key? modifierKey;
  final SingleChildDragTargetBuilder<T> builder;
  final DragTargetWillAccept<T>? onWillAccept;
  final DragTargetAccept<T>? onAccept;
  final DragTargetAcceptWithDetails<T>? onAcceptWithDetails;
  final DragTargetLeave<T>? onLeave;
  final DragTargetMove<T>? onMove;
  final HitTestBehavior hitTestBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DragTarget<T>(
      key: modifierKey,
      builder: (context, candidateData, rejectedData) => builder(
        context,
        candidateData,
        rejectedData,
        child,
      ),
      onAccept: onAccept,
      onAcceptWithDetails: onAcceptWithDetails,
      onLeave: onLeave,
      onMove: onMove,
      onWillAccept: onWillAccept,
      hitTestBehavior: hitTestBehavior,
    );
  }
}
