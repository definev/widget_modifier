import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/cupertino.dart';

class CupertinoPageTransitionModifier extends SingleChildStatelessModifier {
  const CupertinoPageTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.linearTransition,
  });

  final Animation<double> primaryRouteAnimation;
  final Animation<double> secondaryRouteAnimation;
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

class CupertinoFullscreenDialogTransitionModifier
    extends SingleChildStatelessModifier {
  const CupertinoFullscreenDialogTransitionModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.linearTransition,
  });

  final Animation<double> primaryRouteAnimation;
  final Animation<double> secondaryRouteAnimation;
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
