import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class RestorationScopeModifier extends SingleChildStatelessModifier {
  const RestorationScopeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.restorationId,
  }) : super(key: key, child: child);

  final String? restorationId;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RestorationScope(
      key: modifierKey,
      restorationId: restorationId,
      child: child!,
    );
  }
}

class UnmanagedRestorationScopeModifier extends SingleChildStatelessModifier {
  const UnmanagedRestorationScopeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.bucket,
  }) : super(key: key, child: child);

  final RestorationBucket? bucket;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return UnmanagedRestorationScope(
      key: modifierKey,
      bucket: bucket,
      child: child!,
    );
  }
}

class RootRestorationScopeModifier extends SingleChildStatelessModifier {
  const RootRestorationScopeModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.restorationId,
  }) : super(key: key, child: child);

  final String? restorationId;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RootRestorationScope(
      key: modifierKey,
      restorationId: restorationId,
      child: child!,
    );
  }
}
