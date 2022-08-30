import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class TitleModifier extends SingleChildStatelessWidget {
  const TitleModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.title = '',
    required this.color,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
