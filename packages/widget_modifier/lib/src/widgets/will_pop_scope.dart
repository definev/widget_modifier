import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// Registers a callback to veto attempts by the user to dismiss the enclosing
/// [ModalRoute].
///
/// {@tool dartpad}
/// Whenever the back button is pressed, you will get a callback at [onWillPop],
/// which returns a [Future]. If the [Future] returns true, the screen is
/// popped.
///
/// ** See code in examples/api/lib/widgets/will_pop_scope/will_pop_scope.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ModalRoute.addScopedWillPopCallback] and [ModalRoute.removeScopedWillPopCallback],
///    which this widget uses to register and unregister [onWillPop].
///  * [Form], which provides an `onWillPop` callback that enables the form
///    to veto a `pop` initiated by the app's back button.
///
class WillPopScopeModifier extends SingleChildStatelessModifier {
  /// Creates a widget that registers a callback to veto attempts by the user to
  /// dismiss the enclosing [ModalRoute].
  ///
  /// The [child] argument must not be null.
  const WillPopScopeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.onWillPop,
  });

  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  ///
  /// If the callback returns a Future that resolves to false, the enclosing
  /// route will not be popped.
  final WillPopCallback? onWillPop;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return WillPopScope(
      key: modifierKey,
      onWillPop: onWillPop,
      child: child!,
    );
  }
}
