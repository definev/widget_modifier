import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Notifies its listeners when a descendant scrolls.
///
/// To add a listener to a [ScrollNotificationObserver] ancestor:
/// ```dart
/// void listener(ScrollNotification notification) {
///   // Do something, maybe setState()
/// }
/// ScrollNotificationObserver.of(context).addListener(listener)
/// ```
///
/// To remove the listener from a [ScrollNotificationObserver] ancestor:
/// ```dart
/// ScrollNotificationObserver.of(context).removeListener(listener);
/// ```
///
/// Stateful widgets that share an ancestor [ScrollNotificationObserver] typically
/// add a listener in [State.didChangeDependencies] (removing the old one
/// if necessary) and remove the listener in their [State.dispose] method.
///
/// This widget is similar to [NotificationListener]. It supports
/// a listener list instead of just a single listener and its listeners
/// run unconditionally, they do not require a gating boolean return value.
class ScrollNotificationObserverModifier extends SingleChildStatelessModifier {
  /// Create a [ScrollNotificationObserver].
  ///
  /// The [child] parameter must not be null.
  const ScrollNotificationObserverModifier({
    super.key,
    super.modifierKey,
    super.child,
  });

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ScrollNotificationObserver(
      key: modifierKey,
      child: child!,
    );
  }
}
