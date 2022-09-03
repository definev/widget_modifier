import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class RefreshIndicatorModifier extends SingleChildStatelessWidget {
  const RefreshIndicatorModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = RefreshProgressIndicator.defaultStrokeWidth,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  });

  final Key? modifierKey;
  final double displacement;
  final double edgeOffset;
  final RefreshCallback onRefresh;
  final Color? color;
  final Color? backgroundColor;
  final ScrollNotificationPredicate notificationPredicate;
  final String? semanticsLabel;
  final String? semanticsValue;
  final double strokeWidth;
  final RefreshIndicatorTriggerMode triggerMode;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RefreshIndicator(
      key: modifierKey,
      backgroundColor: backgroundColor,
      color: color,
      displacement: displacement,
      edgeOffset: edgeOffset,
      notificationPredicate: notificationPredicate,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeWidth: strokeWidth,
      triggerMode: triggerMode,
      onRefresh: onRefresh,
      child: child!,
    );
  }
}
