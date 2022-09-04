import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class DropdownButtonHideUnderlineModifier extends SingleChildStatelessModifier {
  const DropdownButtonHideUnderlineModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
  }) : super(key: key, child: child);

  @override
  

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DropdownButtonHideUnderline(
      key: modifierKey,
      child: child!,
    );
  }
}
