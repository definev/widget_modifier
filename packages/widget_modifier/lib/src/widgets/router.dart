import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A convenience widget that registers a callback for when the back button is pressed.
///
/// In order to use this widget, there must be an ancestor [Router] widget in the tree
/// that has a [RootBackButtonDispatcher]. e.g. The [Router] widget created by the
/// [MaterialApp.router] has a built-in [RootBackButtonDispatcher] by default.
///
/// It only applies to platforms that accept back button clicks, such as Android.
///
/// It can be useful for scenarios, in which you create a different state in your
/// screen but don't want to use a new page for that.
class BackButtonListenerModifier extends SingleChildStatelessModifier {
  /// Creates a BackButtonListener widget .
  ///
  /// The [child] and [onBackButtonPressed] arguments must not be null.
  const BackButtonListenerModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.onBackButtonPressed,
  });

  /// The callback function that will be called when the back button is pressed.
  ///
  /// It must return a boolean future with true if this child will handle the request;
  /// otherwise, return a boolean future with false.
  final ValueGetter<Future<bool>> onBackButtonPressed;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BackButtonListener(
      key: modifierKey,
      onBackButtonPressed: onBackButtonPressed,
      child: child!,
    );
  }
}
