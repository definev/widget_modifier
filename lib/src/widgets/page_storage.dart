import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class PageStorageModifier extends SingleChildStatelessWidget {
  const PageStorageModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.bucket,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
