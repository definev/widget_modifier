import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class IconThemeModifier extends SingleChildStatelessModifier {
  const IconThemeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.data,
  }) : super(key: key, child: child);

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
