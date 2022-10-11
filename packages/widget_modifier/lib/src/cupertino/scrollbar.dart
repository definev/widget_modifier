// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:flutter/cupertino.dart';

import '../widgets/scrollbar.dart';

/// An iOS style scrollbar.
///
/// To add a scrollbar to a [ScrollView], simply wrap the scroll view widget in
/// a [CupertinoScrollbar] widget.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=DbkIQSvwnZc}
///
/// {@macro flutter.widgets.Scrollbar}
///
/// When dragging a [CupertinoScrollbar] thumb, the thickness and radius will
/// animate from [thickness] and [radius] to [thicknessWhileDragging] and
/// [radiusWhileDragging], respectively.
///
/// {@tool dartpad}
/// This sample shows a [CupertinoScrollbar] that fades in and out of view as scrolling occurs.
/// The scrollbar will fade into view as the user scrolls, and fade out when scrolling stops.
/// The `thickness` of the scrollbar will animate from 6 pixels to the `thicknessWhileDragging` of 10
/// when it is dragged by the user. The `radius` of the scrollbar thumb corners will animate from 34
/// to the `radiusWhileDragging` of 0 when the scrollbar is being dragged by the user.
///
/// ** See code in examples/api/lib/cupertino/scrollbar/cupertino_scrollbar.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// When [thumbVisibility] is true, the scrollbar thumb will remain visible without the
/// fade animation. This requires that a [ScrollController] is provided to controller,
/// or that the [PrimaryScrollController] is available. [isAlwaysShown] is
/// deprecated in favor of `thumbVisibility`.
///
/// ** See code in examples/api/lib/cupertino/scrollbar/cupertino_scrollbar.1.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ListView], which displays a linear, scrollable list of children.
///  * [GridView], which displays a 2 dimensional, scrollable array of children.
///  * [Scrollbar], a Material Design scrollbar.
///  * [RawScrollbar], a basic scrollbar that fades in and out, extended
///    by this class to add more animations and behaviors.
class CupertinoScrollbarModifier extends RawScrollbarModifier {
  /// Creates an iOS style scrollbar that wraps the given [child].
  ///
  /// The [child] should be a source of [ScrollNotification] notifications,
  /// typically a [Scrollable] widget.
  const CupertinoScrollbarModifier({
    super.key,
    super.child,
    super.controller,
    super.notificationPredicate,
    double super.thickness = CupertinoScrollbar.defaultThickness,
    this.thicknessWhileDragging = CupertinoScrollbar.defaultThicknessWhileDragging,
    Radius super.radius = CupertinoScrollbar.defaultRadius,
    this.radiusWhileDragging = CupertinoScrollbar.defaultRadiusWhileDragging,
    super.scrollbarOrientation,
    @Deprecated(
      'Use thumbVisibility instead. '
      'This feature was deprecated after v2.9.0-1.0.pre.',
    )
        bool? isAlwaysShown,
  });

  /// The thickness of the scrollbar when it's being dragged by the user.
  ///
  /// When the user starts dragging the scrollbar, the thickness will animate
  /// from [thickness] to this value, then animate back when the user stops
  /// dragging the scrollbar.
  final double thicknessWhileDragging;
  
  /// The radius of the scrollbar edges when the scrollbar is being dragged by
  /// the user.
  ///
  /// When the user starts dragging the scrollbar, the radius will animate
  /// from [radius] to this value, then animate back when the user stops
  /// dragging the scrollbar.
  final Radius radiusWhileDragging;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoScrollbar(
      key: modifierKey,
      controller: controller,
      isAlwaysShown: isAlwaysShown,
      notificationPredicate: notificationPredicate,
      radius: radius ?? CupertinoScrollbar.defaultRadius,
      radiusWhileDragging: radiusWhileDragging,
      scrollbarOrientation: scrollbarOrientation,
      thickness: thickness ?? CupertinoScrollbar.defaultThickness,
      thicknessWhileDragging: thicknessWhileDragging,
      thumbVisibility: thumbVisibility,
      child: child!,
    );
  }
}
