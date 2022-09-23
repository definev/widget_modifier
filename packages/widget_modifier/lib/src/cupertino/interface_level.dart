import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/cupertino.dart';

class CupertinoUserInterfaceLevelModifier extends SingleChildStatelessModifier {
  const CupertinoUserInterfaceLevelModifier({
    super.key,
    super.child,
    super.modifierKey,
    required CupertinoUserInterfaceLevelData data,
  }) : _data = data;

  final CupertinoUserInterfaceLevelData _data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoUserInterfaceLevel(
      key: modifierKey,
      data: _data,
      child: child!,
    );
  }
}
