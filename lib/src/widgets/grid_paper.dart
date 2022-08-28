import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class GridPaperModifier extends SingleChildStatelessWidget {
  const GridPaperModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.color = const Color(0x7FC3E8F3),
    this.interval = 100.0,
    this.divisions = 2,
    this.subdivisions = 5,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final Color color;
  final double interval;
  final int divisions;
  final int subdivisions;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return GridPaper(
      key: modifierKey,
      color: color,
      divisions: divisions,
      interval: interval,
      subdivisions: subdivisions,
      child: child,
    );
  }
}
