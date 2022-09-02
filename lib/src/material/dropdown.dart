import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class DropdownButtonHideUnderlineModifier extends SingleChildStatelessWidget {
  const DropdownButtonHideUnderlineModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
  }) : super(key: key, child: child);

  final Key? modifierKey;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DropdownButtonHideUnderline(
      key: modifierKey,
      child: child!,
    );
  }
}
