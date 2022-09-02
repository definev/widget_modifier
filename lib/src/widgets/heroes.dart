import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class HeroModifier extends SingleChildStatelessWidget {
  const HeroModifier({
    super.key,
    required this.tag,
    this.modifierKey,
    this.createRectTween,
    this.flightShuttleBuilder,
    this.placeholderBuilder,
    this.transitionOnUserGestures = false,
    super.child,
  });

  final Key? modifierKey;
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

class HeroModeModifier extends SingleChildStatelessWidget {
  const HeroModeModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.enabled = true,
  });

  final Key? modifierKey;
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
