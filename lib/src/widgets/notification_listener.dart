import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class NotificationListenerModifier<T extends Notification>
    extends SingleChildStatelessWidget {
  const NotificationListenerModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.onNotification,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
