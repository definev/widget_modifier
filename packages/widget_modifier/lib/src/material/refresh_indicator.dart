import 'package:flutter/material.dart';

import '../modifier.dart';

/// A widget that supports the Material "swipe to refresh" idiom.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=ORApMlzwMdM}
///
/// When the child's [Scrollable] descendant overscrolls, an animated circular
/// progress indicator is faded into view. When the scroll ends, if the
/// indicator has been dragged far enough for it to become completely opaque,
/// the [onRefresh] callback is called. The callback is expected to update the
/// scrollable's contents and then complete the [Future] it returns. The refresh
/// indicator disappears after the callback's [Future] has completed.
///
/// The trigger mode is configured by [RefreshIndicator.triggerMode].
///
/// {@tool dartpad}
/// This example shows how [RefreshIndicator] can be triggered in different ways.
///
/// ** See code in examples/api/lib/material/refresh_indicator/refresh_indicator.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows how to trigger [RefreshIndicator] in a nested scroll view using
/// the [notificationPredicate] property.
///
/// ** See code in examples/api/lib/material/refresh_indicator/refresh_indicator.1.dart **
/// {@end-tool}
///
/// ## Troubleshooting
///
/// ### Refresh indicator does not show up
///
/// The [RefreshIndicator] will appear if its scrollable descendant can be
/// overscrolled, i.e. if the scrollable's content is bigger than its viewport.
/// To ensure that the [RefreshIndicator] will always appear, even if the
/// scrollable's content fits within its viewport, set the scrollable's
/// [Scrollable.physics] property to [AlwaysScrollableScrollPhysics]:
///
/// ```dart
/// ListView(
///   physics: const AlwaysScrollableScrollPhysics(),
///   children: ...
/// )
/// ```
///
/// A [RefreshIndicator] can only be used with a vertical scroll view.
///
/// See also:
///
///  * <https://material.io/design/platform-guidance/android-swipe-to-refresh.html>
///  * [RefreshIndicatorState], can be used to programmatically show the refresh indicator.
///  * [RefreshProgressIndicator], widget used by [RefreshIndicator] to show
///    the inner circular progress spinner during refreshes.
///  * [CupertinoSliverRefreshControl], an iOS equivalent of the pull-to-refresh pattern.
///    Must be used as a sliver inside a [CustomScrollView] instead of wrapping
///    around a [ScrollView] because it's a part of the scrollable instead of
///    being overlaid on top of it.
class RefreshIndicatorModifier extends SingleChildStatelessModifier {
  /// Creates a refresh indicator.
  ///
  /// The [onRefresh], [child], and [notificationPredicate] arguments must be
  /// non-null. The default
  /// [displacement] is 40.0 logical pixels.
  ///
  /// The [semanticsLabel] is used to specify an accessibility label for this widget.
  /// If it is null, it will be defaulted to [MaterialLocalizations.refreshIndicatorSemanticLabel].
  /// An empty string may be passed to avoid having anything read by screen reading software.
  /// The [semanticsValue] may be used to specify progress on the widget.
  const RefreshIndicatorModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = RefreshProgressIndicator.defaultStrokeWidth,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  });

  
  /// The distance from the child's top or bottom [edgeOffset] where
  /// the refresh indicator will settle. During the drag that exposes the refresh
  /// indicator, its actual displacement may significantly exceed this value.
  ///
  /// In most cases, [displacement] distance starts counting from the parent's
  /// edges. However, if [edgeOffset] is larger than zero then the [displacement]
  /// value is calculated from that offset instead of the parent's edge.
  final double displacement;

  /// The offset where [RefreshProgressIndicator] starts to appear on drag start.
  ///
  /// Depending whether the indicator is showing on the top or bottom, the value
  /// of this variable controls how far from the parent's edge the progress
  /// indicator starts to appear. This may come in handy when, for example, the
  /// UI contains a top [Widget] which covers the parent's edge where the progress
  /// indicator would otherwise appear.
  ///
  /// By default, the edge offset is set to 0.
  ///
  /// See also:
  ///
  ///  * [displacement], can be used to change the distance from the edge that
  ///    the indicator settles.
  final double edgeOffset;

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  final RefreshCallback onRefresh;

  /// The progress indicator's foreground color. The current theme's
  /// [ColorScheme.primary] by default.
  final Color? color;

  /// The progress indicator's background color. The current theme's
  /// [ThemeData.canvasColor] by default.
  final Color? backgroundColor;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  /// {@macro flutter.progress_indicator.ProgressIndicator.semanticsLabel}
  ///
  /// This will be defaulted to [MaterialLocalizations.refreshIndicatorSemanticLabel]
  /// if it is null.
  final String? semanticsLabel;

  /// {@macro flutter.progress_indicator.ProgressIndicator.semanticsValue}
  final String? semanticsValue;

  /// Defines `strokeWidth` for `RefreshIndicator`.
  ///
  /// By default, the value of `strokeWidth` is 2.0 pixels.
  final double strokeWidth;

  /// Defines how this [RefreshIndicator] can be triggered when users overscroll.
  ///
  /// The [RefreshIndicator] can be pulled out in two cases,
  /// 1, Keep dragging if the scrollable widget at the edge with zero scroll position
  ///    when the drag starts.
  /// 2, Keep dragging after overscroll occurs if the scrollable widget has
  ///    a non-zero scroll position when the drag starts.
  ///
  /// If this is [RefreshIndicatorTriggerMode.anywhere], both of the cases above can be triggered.
  ///
  /// If this is [RefreshIndicatorTriggerMode.onEdge], only case 1 can be triggered.
  ///
  /// Defaults to [RefreshIndicatorTriggerMode.onEdge].
  final RefreshIndicatorTriggerMode triggerMode;


  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RefreshIndicator(
      key: modifierKey,
      backgroundColor: backgroundColor,
      color: color,
      displacement: displacement,
      edgeOffset: edgeOffset,
      notificationPredicate: notificationPredicate,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeWidth: strokeWidth,
      triggerMode: triggerMode,
      onRefresh: onRefresh,
      child: child!,
    );
  }
}
