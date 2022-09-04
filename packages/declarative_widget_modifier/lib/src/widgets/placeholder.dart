import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class PlaceholderModifier extends SingleChildStatelessModifier {
  const PlaceholderModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.color = const Color(0xFF455A64),
    this.strokeWidth = 2.0,
    this.fallbackWidth = 400.0,
    this.fallbackHeight = 400.0,
  }) : super(key: key, child: child);

  final Color color;
  final double strokeWidth;
  final double fallbackWidth;
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
