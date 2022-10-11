// ignore_for_file: deprecated_member_use_from_same_package, deprecated_member_use

import 'package:flutter/material.dart';

import '../modifier.dart';

/// A Material Design scrollbar.
///
/// To add a scrollbar to a [ScrollView], wrap the scroll view
/// widget in a [Scrollbar] widget.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=DbkIQSvwnZc}
///
/// {@macro flutter.widgets.Scrollbar}
///
/// Dynamically changes to a [CupertinoScrollbar], an iOS style scrollbar, by
/// default on the iOS platform.
///
/// The color of the Scrollbar thumb will change when [MaterialState.dragged],
/// or [MaterialState.hovered] on desktop and web platforms. These stateful
/// color choices can be changed using [ScrollbarThemeData.thumbColor].
///
/// {@tool dartpad}
/// This sample shows a [Scrollbar] that executes a fade animation as scrolling
/// occurs. The Scrollbar will fade into view as the user scrolls, and fade out
/// when scrolling stops.
///
/// ** See code in examples/api/lib/material/scrollbar/scrollbar.0.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// When [thumbVisibility] is true, the scrollbar thumb will remain visible
/// without the fade animation. This requires that a [ScrollController] is
/// provided to controller, or that the [PrimaryScrollController] is available.
///
/// When a [ScrollView.scrollDirection] is [Axis.horizontal], it is recommended
/// that the [Scrollbar] is always visible, since scrolling in the horizontal
/// axis is less discoverable.
///
/// ** See code in examples/api/lib/material/scrollbar/scrollbar.1.dart **
/// {@end-tool}
///
/// A scrollbar track can be added using [trackVisibility]. This can also be
/// drawn when triggered by a hover event, or based on any [MaterialState] by
/// using [ScrollbarThemeData.trackVisibility].
///
/// The [thickness] of the track and scrollbar thumb can be changed dynamically
/// in response to [MaterialState]s using [ScrollbarThemeData.thickness].
///
/// See also:
///
///  * [RawScrollbar], a basic scrollbar that fades in and out, extended
///    by this class to add more animations and behaviors.
///  * [ScrollbarTheme], which configures the Scrollbar's appearance.
///  * [CupertinoScrollbar], an iOS style scrollbar.
///  * [ListView], which displays a linear, scrollable list of children.
///  * [GridView], which displays a 2 dimensional, scrollable array of children.
class ScrollbarModifier extends SingleChildStatelessModifier {
  /// Creates a Material Design scrollbar that by default will connect to the
  /// closest Scrollable descendant of [child].
  ///
  /// The [child] should be a source of [ScrollNotification] notifications,
  /// typically a [Scrollable] widget.
  ///
  /// If the [controller] is null, the default behavior is to
  /// enable scrollbar dragging using the [PrimaryScrollController].
  ///
  /// When null, [thickness] defaults to 8.0 pixels on desktop and web, and 4.0
  /// pixels when on mobile platforms. A null [radius] will result in a default
  /// of an 8.0 pixel circular radius about the corners of the scrollbar thumb,
  /// except for when executing on [TargetPlatform.android], which will render the
  /// thumb without a radius.
  const ScrollbarModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.controller,
    this.thumbVisibility,
    this.trackVisibility,
    this.thickness,
    this.radius,
    this.notificationPredicate,
    this.interactive,
    this.scrollbarOrientation,
    @Deprecated(
      'Use thumbVisibility instead. '
      'This feature was deprecated after v2.9.0-1.0.pre.',
    )
        this.isAlwaysShown,
    @Deprecated(
      'Use ScrollbarThemeData.trackVisibility to resolve based on the current state instead. '
      'This feature was deprecated after v2.9.0-1.0.pre.',
    )
        this.showTrackOnHover,
    @Deprecated(
      'Use ScrollbarThemeData.thickness to resolve based on the current state instead. '
      'This feature was deprecated after v2.9.0-1.0.pre.',
    )
        this.hoverThickness,
  });

  
  /// {@macro flutter.widgets.Scrollbar.controller}
  final ScrollController? controller;

  /// {@macro flutter.widgets.Scrollbar.thumbVisibility}
  ///
  /// If this property is null, then [ScrollbarThemeData.thumbVisibility] of
  /// [ThemeData.scrollbarTheme] is used. If that is also null, the default value
  /// is false.
  ///
  /// If the thumb visibility is related to the scrollbar's material state,
  /// use the global [ScrollbarThemeData.thumbVisibility] or override the
  /// sub-tree's theme data.
  ///
  /// Replaces deprecated [isAlwaysShown].
  final bool? thumbVisibility;

  /// {@macro flutter.widgets.Scrollbar.isAlwaysShown}
  ///
  /// To show the scrollbar thumb based on a [MaterialState], use
  /// [ScrollbarThemeData.thumbVisibility].
  @Deprecated(
    'Use thumbVisibility instead. '
    'This feature was deprecated after v2.9.0-1.0.pre.',
  )
  final bool? isAlwaysShown;

  /// {@macro flutter.widgets.Scrollbar.trackVisibility}
  ///
  /// If this property is null, then [ScrollbarThemeData.trackVisibility] of
  /// [ThemeData.scrollbarTheme] is used. If that is also null, the default value
  /// is false.
  ///
  /// If the track visibility is related to the scrollbar's material state,
  /// use the global [ScrollbarThemeData.trackVisibility] or override the
  /// sub-tree's theme data.
  ///
  /// Replaces deprecated [showTrackOnHover].
  final bool? trackVisibility;

  /// Controls if the track will show on hover and remain, including during drag.
  ///
  /// If this property is null, then [ScrollbarThemeData.showTrackOnHover] of
  /// [ThemeData.scrollbarTheme] is used. If that is also null, the default value
  /// is false.
  ///
  /// This is deprecated, [trackVisibility] or [ScrollbarThemeData.trackVisibility]
  /// should be used instead.
  @Deprecated(
    'Use ScrollbarThemeData.trackVisibility to resolve based on the current state instead. '
    'This feature was deprecated after v2.9.0-1.0.pre.',
  )
  final bool? showTrackOnHover;

  /// The thickness of the scrollbar when a hover state is active and
  /// [showTrackOnHover] is true.
  ///
  /// If this property is null, then [ScrollbarThemeData.thickness] of
  /// [ThemeData.scrollbarTheme] is used to resolve a thickness. If that is also
  /// null, the default value is 12.0 pixels.
  ///
  /// This is deprecated, use [ScrollbarThemeData.thickness] to resolve based on
  /// the current state instead.
  @Deprecated(
    'Use ScrollbarThemeData.thickness to resolve based on the current state instead. '
    'This feature was deprecated after v2.9.0-1.0.pre.',
  )
  final double? hoverThickness;

  /// The thickness of the scrollbar in the cross axis of the scrollable.
  ///
  /// If null, the default value is platform dependent. On [TargetPlatform.android],
  /// the default thickness is 4.0 pixels. On [TargetPlatform.iOS],
  /// [CupertinoScrollbar.defaultThickness] is used. The remaining platforms have a
  /// default thickness of 8.0 pixels.
  final double? thickness;

  /// The [Radius] of the scrollbar thumb's rounded rectangle corners.
  ///
  /// If null, the default value is platform dependent. On [TargetPlatform.android],
  /// no radius is applied to the scrollbar thumb. On [TargetPlatform.iOS],
  /// [CupertinoScrollbar.defaultRadius] is used. The remaining platforms have a
  /// default [Radius.circular] of 8.0 pixels.
  final Radius? radius;

  /// {@macro flutter.widgets.Scrollbar.interactive}
  final bool? interactive;

  /// {@macro flutter.widgets.Scrollbar.notificationPredicate}
  final ScrollNotificationPredicate? notificationPredicate;

  /// {@macro flutter.widgets.Scrollbar.scrollbarOrientation}
  final ScrollbarOrientation? scrollbarOrientation;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Scrollbar(
      key: modifierKey,
      controller: controller,
      hoverThickness: hoverThickness,
      interactive: interactive,
      isAlwaysShown: isAlwaysShown,
      notificationPredicate: notificationPredicate,
      radius: radius,
      scrollbarOrientation: scrollbarOrientation,
      showTrackOnHover: showTrackOnHover,
      thickness: thickness,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      child: child!,
    );
  }
}
