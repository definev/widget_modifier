import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DismissibleModifier extends SingleChildStatelessWidget {
  const DismissibleModifier({
    Key? key,
    Widget? child,
    required this.modifierKey,
    this.background,
    this.secondaryBackground,
    this.confirmDismiss,
    this.onResize,
    this.onUpdate,
    this.onDismissed,
    this.direction = DismissDirection.horizontal,
    this.resizeDuration = const Duration(milliseconds: 300),
    this.dismissThresholds = const <DismissDirection, double>{},
    this.movementDuration = const Duration(milliseconds: 200),
    this.crossAxisEndOffset = 0.0,
    this.dragStartBehavior = DragStartBehavior.start,
    this.behavior = HitTestBehavior.opaque,
  })  : assert(secondaryBackground == null || background != null),
        super(key: key, child: child);

  final Key modifierKey;
  final Widget? background;
  final Widget? secondaryBackground;
  final ConfirmDismissCallback? confirmDismiss;
  final VoidCallback? onResize;
  final DismissDirectionCallback? onDismissed;
  final DismissDirection direction;
  final Duration? resizeDuration;
  final Map<DismissDirection, double> dismissThresholds;
  final Duration movementDuration;
  final double crossAxisEndOffset;
  final DragStartBehavior dragStartBehavior;
  final HitTestBehavior behavior;
  final DismissUpdateCallback? onUpdate;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Dismissible(
      key: modifierKey,
      background: background,
      behavior: behavior,
      confirmDismiss: confirmDismiss,
      crossAxisEndOffset: crossAxisEndOffset,
      direction: direction,
      dismissThresholds: dismissThresholds,
      dragStartBehavior: dragStartBehavior,
      movementDuration: movementDuration,
      onDismissed: onDismissed,
      onResize: onResize,
      onUpdate: onUpdate,
      resizeDuration: resizeDuration,
      secondaryBackground: secondaryBackground,
      child: child!,
    );
  }
}
