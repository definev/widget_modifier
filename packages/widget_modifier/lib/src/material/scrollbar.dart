// ignore_for_file: deprecated_member_use_from_same_package, deprecated_member_use

import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class ScrollbarModifier extends SingleChildStatelessModifier {
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

  final ScrollController? controller;
  final bool? thumbVisibility;
  @Deprecated(
    'Use thumbVisibility instead. '
    'This feature was deprecated after v2.9.0-1.0.pre.',
  )
  final bool? isAlwaysShown;
  final bool? trackVisibility;
  @Deprecated(
    'Use ScrollbarThemeData.trackVisibility to resolve based on the current state instead. '
    'This feature was deprecated after v2.9.0-1.0.pre.',
  )
  final bool? showTrackOnHover;
  @Deprecated(
    'Use ScrollbarThemeData.thickness to resolve based on the current state instead. '
    'This feature was deprecated after v2.9.0-1.0.pre.',
  )
  final double? hoverThickness;
  final double? thickness;
  final Radius? radius;
  final bool? interactive;
  final ScrollNotificationPredicate? notificationPredicate;
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
