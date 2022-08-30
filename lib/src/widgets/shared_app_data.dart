import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class SharedAppDataModifier extends SingleChildStatelessWidget {
  const SharedAppDataModifier({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SharedAppData(
      key: key,
      child: child!,
    );
  }
}
