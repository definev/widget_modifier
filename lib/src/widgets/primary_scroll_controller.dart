import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class PrimaryScrollControllerModifier extends SingleChildStatelessWidget {
  const PrimaryScrollControllerModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.controller,
    this.automaticallyInheritForPlatforms,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key, child: child);

  const PrimaryScrollControllerModifier.none({
    Key? key,
    Widget? child,
    this.modifierKey,
  })  : automaticallyInheritForPlatforms = const <TargetPlatform>{},
        scrollDirection = null,
        controller = null,
        super(key: key, child: child);

  final Key? modifierKey;
  final ScrollController? controller;
  final Axis? scrollDirection;
  final Set<TargetPlatform>? automaticallyInheritForPlatforms;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    if (controller == null) {
      return PrimaryScrollController.none(child: child!);
    }
    return PrimaryScrollController(
      controller: controller!,
      child: child!,
    );
  }
}
