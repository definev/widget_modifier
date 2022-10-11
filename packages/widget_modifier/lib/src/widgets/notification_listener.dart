import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that listens for [Notification]s bubbling up the tree.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=cAnFbFoGM50}
///
/// Notifications will trigger the [onNotification] callback only if their
/// [runtimeType] is a subtype of `T`.
///
/// To dispatch notifications, use the [Notification.dispatch] method.
class NotificationListenerModifier<T extends Notification> extends SingleChildStatelessModifier {
  /// Creates a widget that listens for notifications.
  const NotificationListenerModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.onNotification,
  });

  /// Called when a notification of the appropriate type arrives at this
  /// location in the tree.
  ///
  /// Return true to cancel the notification bubbling. Return false to
  /// allow the notification to continue to be dispatched to further ancestors.
  ///
  /// Notifications vary in terms of when they are dispatched. There are two
  /// main possibilities: dispatch between frames, and dispatch during layout.
  ///
  /// For notifications that dispatch during layout, such as those that inherit
  /// from [LayoutChangedNotification], it is too late to call [State.setState]
  /// in response to the notification (as layout is currently happening in a
  /// descendant, by definition, since notifications bubble up the tree). For
  /// widgets that depend on layout, consider a [LayoutBuilder] instead.
  final NotificationListenerCallback<T>? onNotification;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return NotificationListener<T>(
      key: modifierKey,
      onNotification: onNotification,
      child: child!,
    );
  }
}
