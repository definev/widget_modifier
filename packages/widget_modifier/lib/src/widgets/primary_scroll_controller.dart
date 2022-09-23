import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class PrimaryScrollControllerModifier extends SingleChildStatelessModifier {
  const PrimaryScrollControllerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.controller,
    this.automaticallyInheritForPlatforms,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key, child: child);

  const PrimaryScrollControllerModifier.none({
    Key? key,
    Widget? child,
    super.modifierKey,
  })  : automaticallyInheritForPlatforms = const <TargetPlatform>{},
        scrollDirection = null,
        controller = null,
        super(key: key, child: child);

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
