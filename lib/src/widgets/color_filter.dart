import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class ColorFilteredModifier extends SingleChildStatelessWidget {
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
