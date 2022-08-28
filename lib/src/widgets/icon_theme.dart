import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class IconThemeModifier extends SingleChildStatelessWidget {
  const IconThemeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final IconThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return IconTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
