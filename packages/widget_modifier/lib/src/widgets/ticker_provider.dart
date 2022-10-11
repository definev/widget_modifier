import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Enables or disables tickers (and thus animation controllers) in the widget
/// subtree.
///
/// This only works if [AnimationController] objects are created using
/// widget-aware ticker providers. For example, using a
/// [TickerProviderStateMixin] or a [SingleTickerProviderStateMixin].
class TickerModeModifier extends SingleChildStatelessModifier {
  /// Creates a widget that enables or disables tickers.
  ///
  /// The [enabled] argument must not be null.
  const TickerModeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.enabled,
  });

  /// The requested ticker mode for this subtree.
  ///
  /// The effective ticker mode of this subtree may differ from this value
  /// if there is an ancestor [TickerMode] with this field set to false.
  ///
  /// If true and all ancestor [TickerMode]s are also enabled, then tickers in
  /// this subtree will tick.
  ///
  /// If false, then tickers in this subtree will not tick regardless of any
  /// ancestor [TickerMode]s. Animations driven by such tickers are not paused,
  /// they just don't call their callbacks. Time still elapses.
  final bool enabled;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TickerMode(
      key: modifierKey,
      enabled: enabled,
      child: child!,
    );
  }
}
