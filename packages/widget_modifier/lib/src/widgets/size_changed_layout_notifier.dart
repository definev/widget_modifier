import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that automatically dispatches a [SizeChangedLayoutNotification]
/// when the layout dimensions of its child change.
///
/// The notification is not sent for the initial layout (since the size doesn't
/// change in that case, it's just established).
///
/// To listen for the notification dispatched by this widget, use a
/// [NotificationListener<SizeChangedLayoutNotification>].
///
/// The [Material] class listens for [LayoutChangedNotification]s, including
/// [SizeChangedLayoutNotification]s, to repaint [InkResponse] and [InkWell] ink
/// effects. When a widget is likely to change size, wrapping it in a
/// [SizeChangedLayoutNotifier] will cause the ink effects to correctly repaint
/// when the child changes size.
///
/// See also:
///
///  * [Notification], the base class for notifications that bubble through the
///    widget tree.
class SizeChangedLayoutNotifierModifier extends SingleChildStatelessModifier {
  /// Creates a [SizeChangedLayoutNotifier] that dispatches layout changed
  /// notifications when [child] changes layout size.
  const SizeChangedLayoutNotifierModifier({
    super.key,
    super.child,
    super.modifierKey,
  });

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SizeChangedLayoutNotifier(
      key: modifierKey,
      child: child,
    );
  }
}
