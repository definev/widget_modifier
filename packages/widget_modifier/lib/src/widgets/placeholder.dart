import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that draws a box that represents where other widgets will one day
/// be added.
///
/// This widget is useful during development to indicate that the interface is
/// not yet complete.
///
/// By default, the placeholder is sized to fit its container. If the
/// placeholder is in an unbounded space, it will size itself according to the
/// given [fallbackWidth] and [fallbackHeight].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=LPe56fezmoo}
class PlaceholderModifier extends SingleChildStatelessModifier {
  /// Creates a widget which draws a box.
  const PlaceholderModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.color = const Color(0xFF455A64),
    this.strokeWidth = 2.0,
    this.fallbackWidth = 400.0,
    this.fallbackHeight = 400.0,
  });

  /// The color to draw the placeholder box.
  final Color color;

  /// The width of the lines in the placeholder box.
  final double strokeWidth;

  /// The width to use when the placeholder is in a situation with an unbounded
  /// width.
  ///
  /// See also:
  ///
  ///  * [fallbackHeight], the same but vertically.
  final double fallbackWidth;

  /// The height to use when the placeholder is in a situation with an unbounded
  /// height.
  ///
  /// See also:
  ///
  ///  * [fallbackWidth], the same but horizontally.
  final double fallbackHeight;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Placeholder(
      key: modifierKey,
      strokeWidth: strokeWidth,
      color: color,
      fallbackHeight: fallbackHeight,
      fallbackWidth: fallbackWidth,
      child: child,
    );
  }
}
