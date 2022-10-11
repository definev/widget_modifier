import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Allows subtrees to request to be kept alive in lazy lists.
///
/// This widget is like [KeepAlive] but instead of being explicitly configured,
/// it listens to [KeepAliveNotification] messages from the [child] and other
/// descendants.
///
/// The subtree is kept alive whenever there is one or more descendant that has
/// sent a [KeepAliveNotification] and not yet triggered its
/// [KeepAliveNotification.handle].
///
/// To send these notifications, consider using [AutomaticKeepAliveClientMixin].
class AutomaticKeepAliveModifier extends SingleChildStatelessModifier {
  /// Creates a widget that listens to [KeepAliveNotification]s and maintains a
  /// [KeepAlive] widget appropriately.
  const AutomaticKeepAliveModifier({
    super.key,
    super.child,
    super.modifierKey,
  });

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AutomaticKeepAlive(
      key: modifierKey,
      child: child!,
    );
  }
}
