import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

typedef SingleChildScrollableWidgetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
  Widget? child,
);

class DraggableScrollableSheetModifier extends SingleChildStatelessWidget {
  const DraggableScrollableSheetModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 1.0,
    this.expand = true,
    this.snap = false,
    this.snapSizes,
    this.controller,
    required this.builder,
  });

  final Key? modifierKey;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final bool expand;
  final bool snap;
  final List<double>? snapSizes;
  final DraggableScrollableController? controller;
  final SingleChildScrollableWidgetBuilder builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DraggableScrollableSheet(
      key: modifierKey,
      builder: (context, scrollController) =>
          builder(context, scrollController, child),
      controller: controller,
      expand: expand,
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      snap: snap,
      snapSizes: snapSizes,
    );
  }
}

class DraggableScrollableActuatorModifier extends SingleChildStatelessWidget {
  const DraggableScrollableActuatorModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
  }) : super(key: key, child: child);

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DraggableScrollableActuator(key: modifierKey, child: child!);
  }
}
