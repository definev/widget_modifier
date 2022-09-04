import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class ChipThemeModifier extends SingleChildStatelessModifier {
  const ChipThemeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final ChipThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ChipTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
