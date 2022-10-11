import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' show Quad;

import '../modifier.dart';

/// A signature for widget builders that take a [Quad] of the current viewport.
///
/// See also:
///
///   * [InteractiveViewer.builder], whose builder is of this type.
///   * [WidgetBuilder], which is similar, but takes no viewport.
typedef InteractiveViewerModifierBuilder = Widget Function(BuildContext context, Quad viewport);

/// A widget that enables pan and zoom interactions with its child.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=zrn7V3bMJvg}
///
/// The user can transform the child by dragging to pan or pinching to zoom.
///
/// By default, InteractiveViewer clips its child using [Clip.hardEdge].
/// To prevent this behavior, consider setting [clipBehavior] to [Clip.none].
/// When [clipBehavior] is [Clip.none], InteractiveViewer may draw outside of
/// its original area of the screen, such as when a child is zoomed in and
/// increases in size. However, it will not receive gestures outside of its original area.
/// To prevent dead areas where InteractiveViewer does not receive gestures,
/// don't set [clipBehavior] or be sure that the InteractiveViewer widget is the
/// size of the area that should be interactive.
///
/// The [child] must not be null.
///
/// See also:
///   * The [Flutter Gallery's transformations demo](https://github.com/flutter/gallery/blob/master/lib/demos/reference/transformations_demo.dart),
///     which includes the use of InteractiveViewer.
///   * The [flutter-go demo](https://github.com/justinmc/flutter-go), which includes robust positioning of an InteractiveViewer child
///     that works for all screen sizes and child sizes.
///   * The [Lazy Flutter Performance Session](https://www.youtube.com/watch?v=qax_nOpgz7E), which includes the use of an InteractiveViewer to
///     performantly view subsets of a large set of widgets using the builder constructor.
///
/// {@tool dartpad}
/// This example shows a simple Container that can be panned and zoomed.
///
/// ** See code in examples/api/lib/widgets/interactive_viewer/interactive_viewer.0.dart **
/// {@end-tool}
@immutable
class InteractiveViewerModifier extends SingleChildStatelessModifier {
  /// Create an InteractiveViewer.
  ///
  /// The [child] parameter must not be null.
  const InteractiveViewerModifier({
    super.key,
    super.child,
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
  }) : builder = null;

  /// Creates an InteractiveViewer for a child that is created on demand.
  ///
  /// Can be used to render a child that changes in response to the current
  /// transformation.
  ///
  /// The [builder] parameter must not be null. See its docs for an example of
  /// using it to optimize a large child.
  const InteractiveViewerModifier.builder({
    super.key,
    super.child,
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
    required InteractiveViewerModifierBuilder this.builder,
  }) : constrained = false;

  /// If set to [Clip.none], the child may extend beyond the size of the InteractiveViewer,
  /// but it will not receive gestures in these areas.
  /// Be sure that the InteractiveViewer is the desired size when using [Clip.none].
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// If true, panning is only allowed in the direction of the horizontal axis
  /// or the vertical axis.
  ///
  /// In other words, when this is true, diagonal panning is not allowed. A
  /// single gesture begun along one axis cannot also cause panning along the
  /// other axis without stopping and beginning a new gesture. This is a common
  /// pattern in tables where data is displayed in columns and rows.
  ///
  /// See also:
  ///  * [constrained], which has an example of creating a table that uses
  ///    alignPanAxis.
  final bool alignPanAxis;

  /// A margin for the visible boundaries of the child.
  ///
  /// Any transformation that results in the viewport being able to view outside
  /// of the boundaries will be stopped at the boundary. The boundaries do not
  /// rotate with the rest of the scene, so they are always aligned with the
  /// viewport.
  ///
  /// To produce no boundaries at all, pass infinite [EdgeInsets], such as
  /// `EdgeInsets.all(double.infinity)`.
  ///
  /// No edge can be NaN.
  ///
  /// Defaults to [EdgeInsets.zero], which results in boundaries that are the
  /// exact same size and position as the [child].
  final EdgeInsets boundaryMargin;

  /// Builds the child of this widget.
  ///
  /// Passed with the [InteractiveViewer.builder] constructor. Otherwise, the
  /// [child] parameter must be passed directly, and this is null.
  ///
  /// {@tool dartpad}
  /// This example shows how to use builder to create a [Table] whose cell
  /// contents are only built when they are visible. Built and remove cells are
  /// logged in the console for illustration.
  ///
  /// ** See code in examples/api/lib/widgets/interactive_viewer/interactive_viewer.builder.0.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///   * [ListView.builder], which follows a similar pattern.
  final InteractiveViewerModifierBuilder? builder;

  /// Whether the normal size constraints at this point in the widget tree are
  /// applied to the child.
  ///
  /// If set to false, then the child will be given infinite constraints. This
  /// is often useful when a child should be bigger than the InteractiveViewer.
  ///
  /// For example, for a child which is bigger than the viewport but can be
  /// panned to reveal parts that were initially offscreen, [constrained] must
  /// be set to false to allow it to size itself properly. If [constrained] is
  /// true and the child can only size itself to the viewport, then areas
  /// initially outside of the viewport will not be able to receive user
  /// interaction events. If experiencing regions of the child that are not
  /// receptive to user gestures, make sure [constrained] is false and the child
  /// is sized properly.
  ///
  /// Defaults to true.
  ///
  /// {@tool dartpad}
  /// This example shows how to create a pannable table. Because the table is
  /// larger than the entire screen, setting `constrained` to false is necessary
  /// to allow it to be drawn to its full size. The parts of the table that
  /// exceed the screen size can then be panned into view.
  ///
  /// ** See code in examples/api/lib/widgets/interactive_viewer/interactive_viewer.constrained.0.dart **
  /// {@end-tool}
  final bool constrained;

  /// If false, the user will be prevented from panning.
  ///
  /// Defaults to true.
  ///
  /// See also:
  ///
  ///   * [scaleEnabled], which is similar but for scale.
  final bool panEnabled;

  /// If false, the user will be prevented from scaling.
  ///
  /// Defaults to true.
  ///
  /// See also:
  ///
  ///   * [panEnabled], which is similar but for panning.
  final bool scaleEnabled;

  /// Determines the amount of scale to be performed per pointer scroll.
  ///
  /// Defaults to 200.0, which was arbitrarily chosen to feel natural for most
  /// trackpads and mousewheels on all supported platforms.
  ///
  /// Increasing this value above the default causes scaling to feel slower,
  /// while decreasing it causes scaling to feel faster.
  ///
  /// The amount of scale is calculated as the exponential function of the
  /// [PointerScrollEvent.scrollDelta] to [scaleFactor] ratio. In the Flutter
  /// engine, the mousewheel [PointerScrollEvent.scrollDelta] is hardcoded to 20
  /// per scroll, while a trackpad scroll can be any amount.
  ///
  /// Affects only pointer device scrolling, not pinch to zoom.
  final double scaleFactor;

  /// The maximum allowed scale.
  ///
  /// The scale will be clamped between this and [minScale] inclusively.
  ///
  /// Defaults to 2.5.
  ///
  /// Cannot be null, and must be greater than zero and greater than minScale.
  final double maxScale;

  /// The minimum allowed scale.
  ///
  /// The scale will be clamped between this and [maxScale] inclusively.
  ///
  /// Scale is also affected by [boundaryMargin]. If the scale would result in
  /// viewing beyond the boundary, then it will not be allowed. By default,
  /// boundaryMargin is EdgeInsets.zero, so scaling below 1.0 will not be
  /// allowed in most cases without first increasing the boundaryMargin.
  ///
  /// Defaults to 0.8.
  ///
  /// Cannot be null, and must be a finite number greater than zero and less
  /// than maxScale.
  final double minScale;

  /// Called when the user ends a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will have
  /// already been updated to reflect the change caused by the interaction,
  /// though a pan may cause an inertia animation after this is called as well.
  ///
  /// {@template flutter.widgets.InteractiveViewer.onInteractionEnd}
  /// Will be called even if the interaction is disabled with [panEnabled] or
  /// [scaleEnabled] for both touch gestures and mouse interactions.
  ///
  /// A [GestureDetector] wrapping the InteractiveViewer will not respond to
  /// [GestureDetector.onScaleStart], [GestureDetector.onScaleUpdate], and
  /// [GestureDetector.onScaleEnd]. Use [onInteractionStart],
  /// [onInteractionUpdate], and [onInteractionEnd] to respond to those
  /// gestures.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [onInteractionStart], which handles the start of the same interaction.
  ///  * [onInteractionUpdate], which handles an update to the same interaction.
  final GestureScaleEndCallback? onInteractionEnd;

  /// Called when the user begins a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will not have
  /// changed due to this interaction.
  ///
  /// {@macro flutter.widgets.InteractiveViewer.onInteractionEnd}
  ///
  /// The coordinates provided in the details' `focalPoint` and
  /// `localFocalPoint` are normal Flutter event coordinates, not
  /// InteractiveViewer scene coordinates. See
  /// [TransformationController.toScene] for how to convert these coordinates to
  /// scene coordinates relative to the child.
  ///
  /// See also:
  ///
  ///  * [onInteractionUpdate], which handles an update to the same interaction.
  ///  * [onInteractionEnd], which handles the end of the same interaction.
  final GestureScaleStartCallback? onInteractionStart;

  /// Called when the user updates a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will have
  /// already been updated to reflect the change caused by the interaction, if
  /// the interaction caused the matrix to change.
  ///
  /// {@macro flutter.widgets.InteractiveViewer.onInteractionEnd}
  ///
  /// The coordinates provided in the details' `focalPoint` and
  /// `localFocalPoint` are normal Flutter event coordinates, not
  /// InteractiveViewer scene coordinates. See
  /// [TransformationController.toScene] for how to convert these coordinates to
  /// scene coordinates relative to the child.
  ///
  /// See also:
  ///
  ///  * [onInteractionStart], which handles the start of the same interaction.
  ///  * [onInteractionEnd], which handles the end of the same interaction.
  final GestureScaleUpdateCallback? onInteractionUpdate;

  /// A [TransformationController] for the transformation performed on the
  /// child.
  ///
  /// Whenever the child is transformed, the [Matrix4] value is updated and all
  /// listeners are notified. If the value is set, InteractiveViewer will update
  /// to respect the new value.
  ///
  /// {@tool dartpad}
  /// This example shows how transformationController can be used to animate the
  /// transformation back to its starting position.
  ///
  /// ** See code in examples/api/lib/widgets/interactive_viewer/interactive_viewer.transformation_controller.0.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [ValueNotifier], the parent class of TransformationController.
  ///  * [TextEditingController] for an example of another similar pattern.
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
