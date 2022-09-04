import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class NotificationListenerModifier<T extends Notification>
    extends SingleChildStatelessModifier {
  const NotificationListenerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.onNotification,
  }) : super(key: key, child: child);

  final NotificationListenerCallback<T>? onNotification;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return NotificationListener(
      key: modifierKey,
      onNotification: onNotification,
      child: child!,
    );
  }
}
