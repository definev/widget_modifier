import 'package:widget_modifier/material.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorThemeModifier extends SingleChildStatelessModifier {
  const ProgressIndicatorThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final ProgressIndicatorThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ProgressIndicatorTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
