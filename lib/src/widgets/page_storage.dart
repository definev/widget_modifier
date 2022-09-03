import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class PageStorageModifier extends SingleChildStatelessModifier {
  const PageStorageModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.bucket,
  }) : super(key: key, child: child);

  final PageStorageBucket bucket;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return PageStorage(
      key: modifierKey,
      bucket: bucket,
      child: child!,
    );
  }
}
