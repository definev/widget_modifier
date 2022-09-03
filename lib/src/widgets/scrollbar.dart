// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

const double _kMinThumbExtent = 18.0;
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

class RawScrollbarModifier extends SingleChildStatelessModifier {
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

  final ScrollController? controller;
  final bool? thumbVisibility;
  @Deprecated(
    'Use thumbVisibility instead. '
    'This feature was deprecated after v2.9.0-1.0.pre.',
  )
  final bool? isAlwaysShown;
  final OutlinedBorder? shape;
  final Radius? radius;
  final double? thickness;
  final Color? thumbColor;
  final double minThumbLength;
  final double? minOverscrollLength;
  final bool? trackVisibility;
  final Radius? trackRadius;
  final Color? trackColor;
  final Color? trackBorderColor;
  final Duration fadeDuration;
  final Duration timeToFade;
  final Duration pressDuration;
  final ScrollNotificationPredicate notificationPredicate;
  final bool? interactive;
  final ScrollbarOrientation? scrollbarOrientation;
  final double mainAxisMargin;
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
