// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:declarative_widget_modifier/src/widgets/scrollbar.dart';
import 'package:flutter/cupertino.dart';

class CupertinoScrollbarModifier extends RawScrollbarModifier {
  const CupertinoScrollbarModifier({
    super.key,
    super.child,
    super.controller,
    super.notificationPredicate,
    bool? thumbVisibility,
    double super.thickness = CupertinoScrollbar.defaultThickness,
    this.thicknessWhileDragging =
        CupertinoScrollbar.defaultThicknessWhileDragging,
    Radius super.radius = CupertinoScrollbar.defaultRadius,
    this.radiusWhileDragging = CupertinoScrollbar.defaultRadiusWhileDragging,
    super.scrollbarOrientation,
    @Deprecated(
      'Use thumbVisibility instead. '
      'This feature was deprecated after v2.9.0-1.0.pre.',
    )
        bool? isAlwaysShown,
  });

  final double thicknessWhileDragging;
  final Radius radiusWhileDragging;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoScrollbar(
      key: modifierKey,
      controller: controller,
      isAlwaysShown: isAlwaysShown,
      notificationPredicate: notificationPredicate,
      radius: radius ?? CupertinoScrollbar.defaultRadius,
      radiusWhileDragging: radiusWhileDragging,
      scrollbarOrientation: scrollbarOrientation,
      thickness: thickness ?? CupertinoScrollbar.defaultThickness,
      thicknessWhileDragging: thicknessWhileDragging,
      thumbVisibility: thumbVisibility,
      child: child!,
    );
  }
}
