import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class TitleModifier extends SingleChildStatelessModifier {
  const TitleModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.title = '',
    required this.color,
  }) : super(key: key, child: child);

  final String title;
  final Color color;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Title(
      key: modifierKey,
      color: color,
      title: title,
      child: child!,
    );
  }
}
