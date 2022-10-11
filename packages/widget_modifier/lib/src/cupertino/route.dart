import 'package:flutter/cupertino.dart';

import '../modifier.dart';

/// Provides an iOS-style page transition animation.
///
/// The page slides in from the right and exits in reverse. It also shifts to the left in
/// a parallax motion when another page enters to cover it.
class CupertinoPageTransitionModifier extends SingleChildStatelessModifier {
  /// Creates an iOS-style page transition.
  ///
  ///  * `primaryRouteAnimation` is a linear route animation from 0.0 to 1.0
  ///    when this screen is being pushed.
  ///  * `secondaryRouteAnimation` is a linear route animation from 0.0 to 1.0
  ///    when another screen is being pushed on top of this one.
  ///  * `linearTransition` is whether to perform the transitions linearly.
  ///    Used to precisely track back gesture drags.
  const CupertinoPageTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.linearTransition,
  });

  /// When this page is coming in to cover another page.
  final Animation<double> primaryRouteAnimation;

  /// When this page is becoming covered by another page.
  final Animation<double> secondaryRouteAnimation;

  /// Is linear transition
  final bool linearTransition;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoPageTransition(
      key: modifierKey,
      primaryRouteAnimation: primaryRouteAnimation,
      secondaryRouteAnimation: secondaryRouteAnimation,
      linearTransition: linearTransition,
      child: child!,
    );
  }
}

/// An iOS-style transition used for summoning fullscreen dialogs.
///
/// For example, used when creating a new calendar event by bringing in the next
/// screen from the bottom.
class CupertinoFullscreenDialogTransitionModifier extends SingleChildStatelessModifier {
  /// Creates an iOS-style transition used for summoning fullscreen dialogs.
  ///
  ///  * `primaryRouteAnimation` is a linear route animation from 0.0 to 1.0
  ///    when this screen is being pushed.
  ///  * `secondaryRouteAnimation` is a linear route animation from 0.0 to 1.0
  ///    when another screen is being pushed on top of this one.
  ///  * `linearTransition` is whether to perform the secondary transition linearly.
  ///    Used to precisely track back gesture drags.
  const CupertinoFullscreenDialogTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.linearTransition,
  });

  /// When this page is covering another page.
  final Animation<double> primaryRouteAnimation;

  /// When this page is becoming covered by another page.
  final Animation<double> secondaryRouteAnimation;

  ///
  final bool linearTransition;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoFullscreenDialogTransition(
      key: modifierKey,
      primaryRouteAnimation: primaryRouteAnimation,
      secondaryRouteAnimation: secondaryRouteAnimation,
      linearTransition: linearTransition,
      child: child!,
    );
  }
}
