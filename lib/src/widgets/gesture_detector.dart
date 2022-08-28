import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class GestureDetectorModifier extends SingleChildStatelessWidget {
  const GestureDetectorModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onDoubleTapDown,
    this.onDoubleTap,
    this.onDoubleTapCancel,
    this.onLongPressDown,
    this.onLongPressCancel,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onSecondaryLongPressDown,
    this.onSecondaryLongPressCancel,
    this.onSecondaryLongPress,
    this.onSecondaryLongPressStart,
    this.onSecondaryLongPressMoveUpdate,
    this.onSecondaryLongPressUp,
    this.onSecondaryLongPressEnd,
    this.onTertiaryLongPressDown,
    this.onTertiaryLongPressCancel,
    this.onTertiaryLongPress,
    this.onTertiaryLongPressStart,
    this.onTertiaryLongPressMoveUpdate,
    this.onTertiaryLongPressUp,
    this.onTertiaryLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.behavior,
    this.excludeFromSemantics = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.supportedDevices,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCallback? onTap;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapCallback? onSecondaryTap;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureTapDownCallback? onDoubleTapDown;
  final GestureTapCallback? onDoubleTap;
  final GestureTapCancelCallback? onDoubleTapCancel;
  final GestureLongPressDownCallback? onLongPressDown;
  final GestureLongPressCancelCallback? onLongPressCancel;
  final GestureLongPressCallback? onLongPress;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressDownCallback? onSecondaryLongPressDown;
  final GestureLongPressCancelCallback? onSecondaryLongPressCancel;
  final GestureLongPressCallback? onSecondaryLongPress;
  final GestureLongPressStartCallback? onSecondaryLongPressStart;
  final GestureLongPressMoveUpdateCallback? onSecondaryLongPressMoveUpdate;
  final GestureLongPressUpCallback? onSecondaryLongPressUp;
  final GestureLongPressEndCallback? onSecondaryLongPressEnd;
  final GestureLongPressDownCallback? onTertiaryLongPressDown;
  final GestureLongPressCancelCallback? onTertiaryLongPressCancel;
  final GestureLongPressCallback? onTertiaryLongPress;
  final GestureLongPressStartCallback? onTertiaryLongPressStart;
  final GestureLongPressMoveUpdateCallback? onTertiaryLongPressMoveUpdate;
  final GestureLongPressUpCallback? onTertiaryLongPressUp;
  final GestureLongPressEndCallback? onTertiaryLongPressEnd;
  final GestureDragDownCallback? onVerticalDragDown;
  final GestureDragStartCallback? onVerticalDragStart;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final GestureDragEndCallback? onVerticalDragEnd;
  final GestureDragCancelCallback? onVerticalDragCancel;
  final GestureDragDownCallback? onHorizontalDragDown;
  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragCancelCallback? onHorizontalDragCancel;
  final GestureDragDownCallback? onPanDown;
  final GestureDragStartCallback? onPanStart;
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragEndCallback? onPanEnd;
  final GestureDragCancelCallback? onPanCancel;
  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;
  final GestureForcePressStartCallback? onForcePressStart;
  final GestureForcePressPeakCallback? onForcePressPeak;
  final GestureForcePressUpdateCallback? onForcePressUpdate;
  final GestureForcePressEndCallback? onForcePressEnd;
  final HitTestBehavior? behavior;
  final bool excludeFromSemantics;
  final DragStartBehavior dragStartBehavior;
  final Set<PointerDeviceKind>? supportedDevices;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return GestureDetector(
      key: modifierKey,
      behavior: behavior,
      dragStartBehavior: dragStartBehavior,
      excludeFromSemantics: excludeFromSemantics,
      onDoubleTap: onDoubleTap,
      onDoubleTapCancel: onDoubleTapCancel,
      onDoubleTapDown: onDoubleTapDown,
      onForcePressEnd: onForcePressEnd,
      onForcePressPeak: onForcePressPeak,
      onForcePressStart: onForcePressStart,
      onForcePressUpdate: onForcePressUpdate,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onLongPress: onLongPress,
      onLongPressCancel: onLongPressCancel,
      onLongPressDown: onLongPressDown,
      onLongPressEnd: onLongPressEnd,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onPanCancel: onPanCancel,
      onPanDown: onPanDown,
      onPanEnd: onPanEnd,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onScaleEnd: onScaleEnd,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onSecondaryLongPress: onSecondaryLongPress,
      onSecondaryLongPressCancel: onSecondaryLongPressCancel,
      onSecondaryLongPressDown: onSecondaryLongPressDown,
      onSecondaryLongPressEnd: onSecondaryLongPressEnd,
      onSecondaryLongPressMoveUpdate: onSecondaryLongPressMoveUpdate,
      onSecondaryLongPressStart: onSecondaryLongPressStart,
      onSecondaryLongPressUp: onSecondaryLongPressUp,
      onSecondaryTap: onSecondaryTap,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onTap: onTap,
      onTapCancel: onTapCancel,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTertiaryLongPress: onTertiaryLongPress,
      onTertiaryLongPressCancel: onTertiaryLongPressCancel,
      onTertiaryLongPressDown: onTertiaryLongPressDown,
      onTertiaryLongPressEnd: onTertiaryLongPressEnd,
      onTertiaryLongPressMoveUpdate: onTertiaryLongPressMoveUpdate,
      onTertiaryLongPressStart: onTertiaryLongPressStart,
      onTertiaryLongPressUp: onTertiaryLongPressUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onVerticalDragCancel: onVerticalDragCancel,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: child,
    );
  }
}

class RawGestureDetectorModifier extends SingleChildStatelessWidget {
  const RawGestureDetectorModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.gestures = const <Type, GestureRecognizerFactory>{},
    this.behavior,
    this.semantics,
    this.excludeFromSemantics = false,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final Map<Type, GestureRecognizerFactory> gestures;
  final HitTestBehavior? behavior;
  final bool excludeFromSemantics;
  final SemanticsGestureDelegate? semantics;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RawGestureDetector(
      key: modifierKey,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      gestures: gestures,
      semantics: semantics,
      child: child,
    );
  }
}
