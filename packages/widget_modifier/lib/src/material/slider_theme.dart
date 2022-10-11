import 'package:flutter/material.dart';

import '../modifier.dart';

/// Applies a slider theme to descendant [Slider] widgets.
///
/// A slider theme describes the colors and shape choices of the slider
/// components.
///
/// Descendant widgets obtain the current theme's [SliderThemeData] object using
/// [SliderTheme.of]. When a widget uses [SliderTheme.of], it is automatically
/// rebuilt if the theme later changes.
///
/// The slider is as big as the largest of
/// the [SliderComponentShape.getPreferredSize] of the thumb shape,
/// the [SliderComponentShape.getPreferredSize] of the overlay shape,
/// and the [SliderTickMarkShape.getPreferredSize] of the tick mark shape.
///
/// See also:
///
///  * [SliderThemeData], which describes the actual configuration of a slider
///    theme.
///  * [SliderComponentShape], which can be used to create custom shapes for
///    the [Slider]'s thumb, overlay, and value indicator and the
///    [RangeSlider]'s overlay.
///  * [SliderTrackShape], which can be used to create custom shapes for the
///    [Slider]'s track.
///  * [SliderTickMarkShape], which can be used to create custom shapes for the
///    [Slider]'s tick marks.
///  * [RangeSliderThumbShape], which can be used to create custom shapes for
///    the [RangeSlider]'s thumb.
///  * [RangeSliderValueIndicatorShape], which can be used to create custom
///    shapes for the [RangeSlider]'s value indicator.
///  * [RangeSliderTrackShape], which can be used to create custom shapes for
///    the [RangeSlider]'s track.
///  * [RangeSliderTickMarkShape], which can be used to create custom shapes for
///    the [RangeSlider]'s tick marks.
class SliderThemeModifier extends SingleChildStatelessModifier {
  /// Applies the given theme [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  const SliderThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// Specifies the color and shape values for descendant slider widgets.
  final SliderThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SliderTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
