// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:flutter/widgets.dart';

import '../modifier.dart';

const double _kMinThumbExtent = 18.0;
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

/// An extendable base class for building scrollbars that fade in and out.
///
/// To add a scrollbar to a [ScrollView], like a [ListView] or a
/// [CustomScrollView], wrap the scroll view widget in a [RawScrollbar] widget.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=DbkIQSvwnZc}
///
/// {@template flutter.widgets.Scrollbar}
/// A scrollbar thumb indicates which portion of a [ScrollView] is actually
/// visible.
///
/// By default, the thumb will fade in and out as the child scroll view
/// scrolls. When [thumbVisibility] is true, the scrollbar thumb will remain
/// visible without the fade animation. This requires that the [ScrollController]
/// associated with the Scrollable widget is provided to [controller], or that
/// the [PrimaryScrollController] is being used by that Scrollable widget.
///
/// If the scrollbar is wrapped around multiple [ScrollView]s, it only responds to
/// the nearest ScrollView and shows the corresponding scrollbar thumb by default.
/// The [notificationPredicate] allows the ability to customize which
/// [ScrollNotification]s the Scrollbar should listen to.
///
/// If the child [ScrollView] is infinitely long, the [RawScrollbar] will not be
/// painted. In this case, the scrollbar cannot accurately represent the
/// relative location of the visible area, or calculate the accurate delta to
/// apply when  dragging on the thumb or tapping on the track.
///
/// ### Interaction
///
/// Scrollbars are interactive and can use the [PrimaryScrollController] if
/// a [controller] is not set. Interactive Scrollbar thumbs can be dragged along
/// the main axis of the [ScrollView] to change the [ScrollPosition]. Tapping
/// along the track exclusive of the thumb will trigger a
/// [ScrollIncrementType.page] based on the relative position to the thumb.
///
/// When using the [PrimaryScrollController], it must not be attached to more
/// than one [ScrollPosition]. [ScrollView]s that have not been provided a
/// [ScrollController] and have a [ScrollView.scrollDirection] of
/// [Axis.vertical] will automatically attach their ScrollPosition to the
/// PrimaryScrollController. Provide a unique ScrollController to each
/// [Scrollable] in this case to prevent having multiple ScrollPositions
/// attached to the PrimaryScrollController.
///
/// {@tool dartpad}
/// This sample shows an app with two scrollables in the same route. Since by
/// default, there is one [PrimaryScrollController] per route, and they both have a
/// scroll direction of [Axis.vertical], they would both try to attach to that
/// controller on mobile platforms. The [Scrollbar] cannot support multiple
/// positions attached to the same controller, so one [ListView], and its
/// [Scrollbar] have been provided a unique [ScrollController]. Desktop
/// platforms do not automatically attach to the PrimaryScrollController,
/// requiring [ScrollView.primary] to be true instead in order to use the
/// PrimaryScrollController.
///
/// Alternatively, a new PrimaryScrollController could be created above one of
/// the [ListView]s.
///
/// ** See code in examples/api/lib/widgets/scrollbar/raw_scrollbar.0.dart **
/// {@end-tool}
///
/// ### Automatic Scrollbars on Desktop Platforms
///
/// Scrollbars are added to most [Scrollable] widgets by default on
/// [TargetPlatformVariant.desktop] platforms. This is done through
/// [ScrollBehavior.buildScrollbar] as part of an app's
/// [ScrollConfiguration]. Scrollables that do not use the
/// [PrimaryScrollController] or have a [ScrollController] provided to them
/// will receive a unique ScrollController for use with the Scrollbar. In this
/// case, only one Scrollable can be using the PrimaryScrollController, unless
/// [interactive] is false. To prevent [Axis.vertical] Scrollables from using
/// the PrimaryScrollController, set [ScrollView.primary] to false. Scrollable
/// widgets that do not have automatically applied Scrollbars include
///
///   * [EditableText]
///   * [ListWheelScrollView]
///   * [PageView]
///   * [NestedScrollView]
///   * [DropdownButton]
/// {@endtemplate}
///
/// {@tool dartpad}
/// This sample shows a [RawScrollbar] that executes a fade animation as
/// scrolling occurs. The RawScrollbar will fade into view as the user scrolls,
/// and fade out when scrolling stops. The [GridView] uses the
/// [PrimaryScrollController] since it has an [Axis.vertical] scroll direction
/// and has not been provided a [ScrollController].
///
/// ** See code in examples/api/lib/widgets/scrollbar/raw_scrollbar.1.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// When `thumbVisibility` is true, the scrollbar thumb will remain visible without
/// the fade animation. This requires that a [ScrollController] is provided to
/// `controller` for both the [RawScrollbar] and the [GridView].
/// Alternatively, the [PrimaryScrollController] can be used automatically so long
/// as it is attached to the singular [ScrollPosition] associated with the GridView.
///
/// ** See code in examples/api/lib/widgets/scrollbar/raw_scrollbar.2.dart **
/// {@end-tool}
///
/// See also:
///
///  * [ListView], which displays a linear, scrollable list of children.
///  * [GridView], which displays a 2 dimensional, scrollable array of children.
class RawScrollbarModifier extends SingleChildStatelessModifier {
  /// Creates a basic raw scrollbar that wraps the given [child].
  ///
  /// The [child], or a descendant of the [child], should be a source of
  /// [ScrollNotification] notifications, typically a [Scrollable] widget.
  ///
  /// The [child], [fadeDuration], [pressDuration], and [timeToFade] arguments
  /// must not be null.
  const RawScrollbarModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.controller,
    this.thumbVisibility,
    this.shape,
    this.radius,
    this.thickness,
    this.thumbColor,
    this.minThumbLength = _kMinThumbExtent,
    this.minOverscrollLength,
    this.trackVisibility,
    this.trackRadius,
    this.trackColor,
    this.trackBorderColor,
    this.fadeDuration = _kScrollbarFadeDuration,
    this.timeToFade = _kScrollbarTimeToFade,
    this.pressDuration = Duration.zero,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.interactive,
    this.scrollbarOrientation,
    this.mainAxisMargin = 0.0,
    this.crossAxisMargin = 0.0,
    @Deprecated(
      'Use thumbVisibility instead. '
      'This feature was deprecated after v2.9.0-1.0.pre.',
    )
        this.isAlwaysShown,
  });

  /// {@template flutter.widgets.Scrollbar.controller}
  /// The [ScrollController] used to implement Scrollbar dragging.
  ///
  /// If nothing is passed to controller, the default behavior is to automatically
  /// enable scrollbar dragging on the nearest ScrollController using
  /// [PrimaryScrollController.of].
  ///
  /// If a ScrollController is passed, then dragging on the scrollbar thumb will
  /// update the [ScrollPosition] attached to the controller. A stateful ancestor
  /// of this widget needs to manage the ScrollController and either pass it to
  /// a scrollable descendant or use a PrimaryScrollController to share it.
  ///
  /// {@tool snippet}
  /// Here is an example of using the `controller` parameter to enable
  /// scrollbar dragging for multiple independent ListViews:
  ///
  /// ```dart
  /// final ScrollController controllerOne = ScrollController();
  /// final ScrollController controllerTwo = ScrollController();
  ///
  /// Widget build(BuildContext context) {
  ///   return Column(
  ///     children: <Widget>[
  ///       SizedBox(
  ///        height: 200,
  ///        child: CupertinoScrollbar(
  ///          controller: controllerOne,
  ///          child: ListView.builder(
  ///            controller: controllerOne,
  ///            itemCount: 120,
  ///            itemBuilder: (BuildContext context, int index) => Text('item $index'),
  ///          ),
  ///        ),
  ///      ),
  ///      SizedBox(
  ///        height: 200,
  ///        child: CupertinoScrollbar(
  ///          controller: controllerTwo,
  ///          child: ListView.builder(
  ///            controller: controllerTwo,
  ///            itemCount: 120,
  ///            itemBuilder: (BuildContext context, int index) => Text('list 2 item $index'),
  ///          ),
  ///        ),
  ///      ),
  ///    ],
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  /// {@endtemplate}
  final ScrollController? controller;

  /// {@template flutter.widgets.Scrollbar.thumbVisibility}
  /// Indicates that the scrollbar thumb should be visible, even when a scroll
  /// is not underway.
  ///
  /// When false, the scrollbar will be shown during scrolling
  /// and will fade out otherwise.
  ///
  /// When true, the scrollbar will always be visible and never fade out. This
  /// requires that the Scrollbar can access the [ScrollController] of the
  /// associated Scrollable widget. This can either be the provided [controller],
  /// or the [PrimaryScrollController] of the current context.
  ///
  ///   * When providing a controller, the same ScrollController must also be
  ///     provided to the associated Scrollable widget.
  ///   * The [PrimaryScrollController] is used by default for a [ScrollView]
  ///     that has not been provided a [ScrollController] and that has an
  ///     [Axis.vertical] [ScrollDirection]. This automatic behavior does not
  ///     apply to those with a ScrollDirection of Axis.horizontal. To explicitly
  ///     use the PrimaryScrollController, set [ScrollView.primary] to true.
  ///
  /// Defaults to false when null.
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// final ScrollController controllerOne = ScrollController();
  /// final ScrollController controllerTwo = ScrollController();
  ///
  /// Widget build(BuildContext context) {
  /// return Column(
  ///   children: <Widget>[
  ///     SizedBox(
  ///        height: 200,
  ///        child: Scrollbar(
  ///          thumbVisibility: true,
  ///          controller: controllerOne,
  ///          child: ListView.builder(
  ///            controller: controllerOne,
  ///            itemCount: 120,
  ///            itemBuilder: (BuildContext context, int index) {
  ///              return  Text('item $index');
  ///            },
  ///          ),
  ///        ),
  ///      ),
  ///      SizedBox(
  ///        height: 200,
  ///        child: CupertinoScrollbar(
  ///          thumbVisibility: true,
  ///          controller: controllerTwo,
  ///          child: SingleChildScrollView(
  ///            controller: controllerTwo,
  ///            child: const SizedBox(
  ///              height: 2000,
  ///              width: 500,
  ///              child: Placeholder(),
  ///            ),
  ///          ),
  ///        ),
  ///      ),
  ///    ],
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///   * [RawScrollbarState.showScrollbar], an overridable getter which uses
  ///     this value to override the default behavior.
  ///   * [ScrollView.primary], which indicates whether the ScrollView is the primary
  ///     scroll view associated with the parent [PrimaryScrollController].
  ///   * [PrimaryScrollController], which associates a [ScrollController] with
  ///     a subtree.
  ///
  /// Replaces deprecated [isAlwaysShown].
  /// {@endtemplate}
  ///
  /// Subclass [Scrollbar] can hide and show the scrollbar thumb in response to
  /// [MaterialState]s by using [ScrollbarThemeData.thumbVisibility].
  final bool? thumbVisibility;

  /// {@template flutter.widgets.Scrollbar.isAlwaysShown}
  /// Indicates that the scrollbar thumb should be visible, even when a scroll
  /// is not underway.
  ///
  /// When false, the scrollbar will be shown during scrolling
  /// and will fade out otherwise.
  ///
  /// When true, the scrollbar will always be visible and never fade out. This
  /// requires that the Scrollbar can access the [ScrollController] of the
  /// associated Scrollable widget. This can either be the provided [controller],
  /// or the [PrimaryScrollController] of the current context.
  ///
  ///   * When providing a controller, the same ScrollController must also be
  ///     provided to the associated Scrollable widget.
  ///   * The [PrimaryScrollController] is used by default for a [ScrollView]
  ///     that has not been provided a [ScrollController] and that has an
  ///     [Axis.vertical] [ScrollDirection]. This automatic behavior does not
  ///     apply to those with a ScrollDirection of Axis.horizontal. To explicitly
  ///     use the PrimaryScrollController, set [ScrollView.primary] to true.
  ///
  /// Defaults to false when null.
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// final ScrollController controllerOne = ScrollController();
  /// final ScrollController controllerTwo = ScrollController();
  ///
  /// Widget build(BuildContext context) {
  /// return Column(
  ///   children: <Widget>[
  ///     SizedBox(
  ///        height: 200,
  ///        child: Scrollbar(
  ///          thumbVisibility: true,
  ///          controller: controllerOne,
  ///          child: ListView.builder(
  ///            controller: controllerOne,
  ///            itemCount: 120,
  ///            itemBuilder: (BuildContext context, int index) {
  ///              return  Text('item $index');
  ///            },
  ///          ),
  ///        ),
  ///      ),
  ///      SizedBox(
  ///        height: 200,
  ///        child: CupertinoScrollbar(
  ///          thumbVisibility: true,
  ///          controller: controllerTwo,
  ///          child: SingleChildScrollView(
  ///            controller: controllerTwo,
  ///            child: const SizedBox(
  ///              height: 2000,
  ///              width: 500,
  ///              child: Placeholder(),
  ///            ),
  ///          ),
  ///        ),
  ///      ),
  ///    ],
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///   * [RawScrollbarState.showScrollbar], an overridable getter which uses
  ///     this value to override the default behavior.
  ///   * [ScrollView.primary], which indicates whether the ScrollView is the primary
  ///     scroll view associated with the parent [PrimaryScrollController].
  ///   * [PrimaryScrollController], which associates a [ScrollController] with
  ///     a subtree.
  ///
  /// This is deprecated, [thumbVisibility] should be used instead.
  /// {@endtemplate}
  @Deprecated(
    'Use thumbVisibility instead. '
    'This feature was deprecated after v2.9.0-1.0.pre.',
  )
  final bool? isAlwaysShown;

  /// The [OutlinedBorder] of the scrollbar's thumb.
  ///
  /// Only one of [radius] and [shape] may be specified. For a rounded rectangle,
  /// it's simplest to just specify [radius]. By default, the scrollbar thumb's
  /// shape is a simple rectangle.
  ///
  /// If [shape] is specified, the thumb will take the shape of the passed
  /// [OutlinedBorder] and fill itself with [thumbColor] (or grey if it
  /// is unspecified).
  ///
  /// {@tool dartpad}
  /// This is an example of using a [StadiumBorder] for drawing the [shape] of the
  /// thumb in a [RawScrollbar].
  ///
  /// ** See code in examples/api/lib/widgets/scrollbar/raw_scrollbar.shape.0.dart **
  /// {@end-tool}
  final OutlinedBorder? shape;

  /// The [Radius] of the scrollbar thumb's rounded rectangle corners.
  ///
  /// Scrollbar will be rectangular if [radius] is null, which is the default
  /// behavior.
  final Radius? radius;

  /// The thickness of the scrollbar in the cross axis of the scrollable.
  ///
  /// If null, will default to 6.0 pixels.
  final double? thickness;

  /// The color of the scrollbar thumb.
  ///
  /// If null, defaults to Color(0x66BCBCBC).
  final Color? thumbColor;

  /// The preferred smallest size the scrollbar thumb can shrink to when the total
  /// scrollable extent is large, the current visible viewport is small, and the
  /// viewport is not overscrolled.
  ///
  /// The size of the scrollbar's thumb may shrink to a smaller size than [minThumbLength]
  /// to fit in the available paint area (e.g., when [minThumbLength] is greater
  /// than [ScrollMetrics.viewportDimension] and [mainAxisMargin] combined).
  ///
  /// Mustn't be null and the value has to be greater or equal to
  /// [minOverscrollLength], which in turn is >= 0. Defaults to 18.0.
  final double minThumbLength;

  /// The preferred smallest size the scrollbar thumb can shrink to when viewport is
  /// overscrolled.
  ///
  /// When overscrolling, the size of the scrollbar's thumb may shrink to a smaller size
  /// than [minOverscrollLength] to fit in the available paint area (e.g., when
  /// [minOverscrollLength] is greater than [ScrollMetrics.viewportDimension] and
  /// [mainAxisMargin] combined).
  ///
  /// Overscrolling can be made possible by setting the `physics` property
  /// of the `child` Widget to a `BouncingScrollPhysics`, which is a special
  /// `ScrollPhysics` that allows overscrolling.
  ///
  /// The value is less than or equal to [minThumbLength] and greater than or equal to 0.
  /// When null, it will default to the value of [minThumbLength].
  final double? minOverscrollLength;

  /// {@template flutter.widgets.Scrollbar.trackVisibility}
  /// Indicates that the scrollbar track should be visible.
  ///
  /// When true, the scrollbar track will always be visible so long as the thumb
  /// is visible. If the scrollbar thumb is not visible, the track will not be
  /// visible either.
  ///
  /// Defaults to false when null.
  /// {@endtemplate}
  ///
  /// Subclass [Scrollbar] can hide and show the scrollbar thumb in response to
  /// [MaterialState]s by using [ScrollbarThemeData.trackVisibility].
  final bool? trackVisibility;

  /// The [Radius] of the scrollbar track's rounded rectangle corners.
  ///
  /// Scrollbar's track will be rectangular if [trackRadius] is null, which is
  /// the default behavior.
  final Radius? trackRadius;

  /// The color of the scrollbar track.
  ///
  /// The scrollbar track will only be visible when [trackVisibility] and
  /// [thumbVisibility] are true.
  ///
  /// If null, defaults to Color(0x08000000).
  final Color? trackColor;

  /// The color of the scrollbar track's border.
  ///
  /// The scrollbar track will only be visible when [trackVisibility] and
  /// [thumbVisibility] are true.
  ///
  /// If null, defaults to Color(0x1a000000).
  final Color? trackBorderColor;

  /// The [Duration] of the fade animation.
  ///
  /// Cannot be null, defaults to a [Duration] of 300 milliseconds.
  final Duration fadeDuration;

  /// The [Duration] of time until the fade animation begins.
  ///
  /// Cannot be null, defaults to a [Duration] of 600 milliseconds.
  final Duration timeToFade;

  /// The [Duration] of time that a LongPress will trigger the drag gesture of
  /// the scrollbar thumb.
  ///
  /// Cannot be null, defaults to [Duration.zero].
  final Duration pressDuration;

  /// {@template flutter.widgets.Scrollbar.notificationPredicate}
  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. That means if the
  /// scrollbar is wrapped around multiple [ScrollView]s, it only responds to the
  /// nearest scrollView and shows the corresponding scrollbar thumb.
  /// {@endtemplate}
  final ScrollNotificationPredicate notificationPredicate;

  /// {@template flutter.widgets.Scrollbar.interactive}
  /// Whether the Scrollbar should be interactive and respond to dragging on the
  /// thumb, or tapping in the track area.
  ///
  /// Does not apply to the [CupertinoScrollbar], which is always interactive to
  /// match native behavior. On Android, the scrollbar is not interactive by
  /// default.
  ///
  /// When false, the scrollbar will not respond to gesture or hover events,
  /// and will allow to click through it.
  ///
  /// Defaults to true when null, unless on Android, which will default to false
  /// when null.
  ///
  /// See also:
  ///
  ///   * [RawScrollbarState.enableGestures], an overridable getter which uses
  ///     this value to override the default behavior.
  /// {@endtemplate}
  final bool? interactive;

  /// {@macro flutter.widgets.Scrollbar.scrollbarOrientation}
  final ScrollbarOrientation? scrollbarOrientation;

  /// Distance from the scrollbar's start and end to the edge of the viewport
  /// in logical pixels. It affects the amount of available paint area.
  ///
  /// Mustn't be null and defaults to 0.
  final double mainAxisMargin;

  /// Distance from the scrollbar thumb side to the nearest cross axis edge
  /// in logical pixels.
  ///
  /// Must not be null and defaults to 0.
  final double crossAxisMargin;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RawScrollbar(
      key: modifierKey,
      controller: controller,
      crossAxisMargin: crossAxisMargin,
      fadeDuration: fadeDuration,
      interactive: interactive,
      isAlwaysShown: isAlwaysShown,
      mainAxisMargin: mainAxisMargin,
      minOverscrollLength: minOverscrollLength,
      minThumbLength: minThumbLength,
      notificationPredicate: notificationPredicate,
      pressDuration: pressDuration,
      radius: radius,
      scrollbarOrientation: scrollbarOrientation,
      shape: shape,
      thickness: thickness,
      thumbColor: thumbColor,
      thumbVisibility: thumbVisibility,
      timeToFade: timeToFade,
      trackBorderColor: trackBorderColor,
      trackColor: trackColor,
      trackRadius: trackRadius,
      trackVisibility: trackVisibility,
      child: child!,
    );
  }
}
