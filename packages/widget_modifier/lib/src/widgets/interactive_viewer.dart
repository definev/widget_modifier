import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

import 'package:vector_math/vector_math_64.dart' show Quad;

typedef InteractiveViewerWidgetBuilder = Widget Function(BuildContext context, Quad viewport);

@immutable
class InteractiveViewerModifier extends SingleChildStatelessModifier {
  const InteractiveViewerModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.clipBehavior = Clip.hardEdge,
    this.alignPanAxis = false,
    this.boundaryMargin = EdgeInsets.zero,
    this.constrained = true,
    this.maxScale = 2.5,
    this.minScale = 0.8,
    this.onInteractionEnd,
    this.onInteractionStart,
    this.onInteractionUpdate,
    this.panEnabled = true,
    this.scaleEnabled = true,
    this.scaleFactor = 200.0,
    this.transformationController,
  })  : builder = null,
        super(key: key, child: child);

  const InteractiveViewerModifier.builder({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.clipBehavior = Clip.hardEdge,
    this.alignPanAxis = false,
    this.boundaryMargin = EdgeInsets.zero,
    this.maxScale = 2.5,
    this.minScale = 0.8,
    this.onInteractionEnd,
    this.onInteractionStart,
    this.onInteractionUpdate,
    this.panEnabled = true,
    this.scaleEnabled = true,
    this.scaleFactor = 200.0,
    this.transformationController,
    required InteractiveViewerWidgetBuilder this.builder,
  })  : constrained = false,
        super(key: key, child: child);

  final Clip clipBehavior;
  final bool alignPanAxis;
  final EdgeInsets boundaryMargin;
  final InteractiveViewerWidgetBuilder? builder;
  final bool constrained;
  final bool panEnabled;
  final bool scaleEnabled;
  final double scaleFactor;
  final double maxScale;
  final double minScale;
  final GestureScaleEndCallback? onInteractionEnd;
  final GestureScaleStartCallback? onInteractionStart;
  final GestureScaleUpdateCallback? onInteractionUpdate;
  final TransformationController? transformationController;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return InteractiveViewer(
      key: modifierKey,
      alignPanAxis: alignPanAxis,
      boundaryMargin: boundaryMargin,
      clipBehavior: clipBehavior,
      constrained: constrained,
      maxScale: maxScale,
      minScale: minScale,
      onInteractionEnd: onInteractionEnd,
      onInteractionStart: onInteractionStart,
      onInteractionUpdate: onInteractionUpdate,
      panEnabled: panEnabled,
      scaleEnabled: scaleEnabled,
      scaleFactor: scaleFactor,
      transformationController: transformationController,
      child: child!,
    );
  }
}
