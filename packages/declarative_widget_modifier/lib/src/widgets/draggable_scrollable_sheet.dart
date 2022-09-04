import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

typedef SingleChildScrollableWidgetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
  Widget? child,
);

class DraggableScrollableSheetModifier extends SingleChildStatelessModifier {
  const DraggableScrollableSheetModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 1.0,
    this.expand = true,
    this.snap = false,
    this.snapSizes,
    this.controller,
    required this.builder,
  });

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

class DraggableScrollableActuatorModifier extends SingleChildStatelessModifier {
  const DraggableScrollableActuatorModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
  }) : super(key: key, child: child);

  @override
  

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DraggableScrollableActuator(key: modifierKey, child: child!);
  }
}
