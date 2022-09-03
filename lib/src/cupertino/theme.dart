import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/cupertino.dart';

class CupertinoThemeModifier extends SingleChildStatelessModifier {
  const CupertinoThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  final CupertinoThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
