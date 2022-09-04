import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class CheckboxThemeModifier extends SingleChildStatelessModifier {
  const CheckboxThemeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final CheckboxThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CheckboxTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
