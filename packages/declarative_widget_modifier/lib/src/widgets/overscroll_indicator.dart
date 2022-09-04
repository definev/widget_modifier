import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class StretchingOverscrollIndicatorModifier
    extends SingleChildStatelessModifier {
  const StretchingOverscrollIndicatorModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.axisDirection,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  }) : super(key: key, child: child);

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
