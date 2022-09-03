import 'dart:ui' as ui;

import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class ColorFilteredModifier extends SingleChildStatelessModifier {
  const ColorFilteredModifier({
    Key? key,
    Widget? child,
    this.modfierKey,
    required this.colorFilter,
  }) : super(key: key, child: child);

  final Key? modfierKey;
  final ui.ColorFilter colorFilter;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ColorFiltered(
      key: key,
      colorFilter: colorFilter,
      child: child,
    );
  }
}
