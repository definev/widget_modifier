import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class RestorationScopeModifier extends SingleChildStatelessWidget {
  const RestorationScopeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.restorationId,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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

class UnmanagedRestorationScopeModifier extends SingleChildStatelessWidget {
  const UnmanagedRestorationScopeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.bucket,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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

class RootRestorationScopeModifier extends SingleChildStatelessWidget {
  const RootRestorationScopeModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.restorationId,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
