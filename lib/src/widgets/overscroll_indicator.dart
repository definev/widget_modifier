import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class StretchingOverscrollIndicatorModifier extends SingleChildStatelessWidget {
  const StretchingOverscrollIndicatorModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.axisDirection,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final AxisDirection axisDirection;
  final ScrollNotificationPredicate notificationPredicate;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return StretchingOverscrollIndicator(
      axisDirection: axisDirection,
      notificationPredicate: notificationPredicate,
      child: child,
    );
  }
}
