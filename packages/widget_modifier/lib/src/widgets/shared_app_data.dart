import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class SharedAppDataModifier extends SingleChildStatelessModifier {
  const SharedAppDataModifier({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SharedAppData(
      key: key,
      child: child!,
    );
  }
}
