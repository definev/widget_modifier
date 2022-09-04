import 'dart:ui' as ui;

import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class ImageFilterModifier extends SingleChildStatelessModifier {
  const ImageFilterModifier({
    Key? key,
    Widget? child,
    required this.imageFilter,
    this.enabled = true,
  }) : super(key: key, child: child);

  final ui.ImageFilter imageFilter;
  final bool enabled;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ImageFiltered(
      imageFilter: imageFilter,
      child: child,
    );
  }
}
