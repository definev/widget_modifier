import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class HeroModifier extends SingleChildStatelessModifier {
  const HeroModifier({
    super.key,
    required this.tag,
    super.modifierKey,
    this.createRectTween,
    this.flightShuttleBuilder,
    this.placeholderBuilder,
    this.transitionOnUserGestures = false,
    super.child,
  });

  final Object tag;
  final CreateRectTween? createRectTween;
  final HeroFlightShuttleBuilder? flightShuttleBuilder;
  final HeroPlaceholderBuilder? placeholderBuilder;
  final bool transitionOnUserGestures;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Hero(
      key: modifierKey,
      createRectTween: createRectTween,
      flightShuttleBuilder: flightShuttleBuilder,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: transitionOnUserGestures,
      tag: tag,
      child: child!,
    );
  }
}

class HeroModeModifier extends SingleChildStatelessModifier {
  const HeroModeModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.enabled = true,
  });

  final bool enabled;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return HeroMode(
      key: modifierKey,
      enabled: enabled,
      child: child!,
    );
  }
}
