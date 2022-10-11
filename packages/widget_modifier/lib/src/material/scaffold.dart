import 'package:flutter/material.dart';

import '../modifier.dart';

/// Manages [SnackBar]s and [MaterialBanner]s for descendant [Scaffold]s.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=lytQi-slT5Y}
///
/// This class provides APIs for showing snack bars and material banners at the
/// bottom and top of the screen, respectively.
///
/// To display one of these notifications, obtain the [ScaffoldMessengerState]
/// for the current [BuildContext] via [ScaffoldMessenger.of] and use the
/// [ScaffoldMessengerState.showSnackBar] or the
/// [ScaffoldMessengerState.showMaterialBanner] functions.
///
/// When the [ScaffoldMessenger] has nested [Scaffold] descendants, the
/// ScaffoldMessenger will only present the notification to the root Scaffold of
/// the subtree of Scaffolds. In order to show notifications for the inner, nested
/// Scaffolds, set a new scope by instantiating a new ScaffoldMessenger in
/// between the levels of nesting.
///
/// {@tool dartpad}
/// Here is an example of showing a [SnackBar] when the user presses a button.
///
/// ** See code in examples/api/lib/material/scaffold/scaffold_messenger.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [SnackBar], which is a temporary notification typically shown near the
///    bottom of the app using the [ScaffoldMessengerState.showSnackBar] method.
///  * [MaterialBanner], which is a temporary notification typically shown at the
///    top of the app using the [ScaffoldMessengerState.showMaterialBanner] method.
///  * [debugCheckHasScaffoldMessenger], which asserts that the given context
///    has a [ScaffoldMessenger] ancestor.
///  * Cookbook: [Display a SnackBar](https://flutter.dev/docs/cookbook/design/snackbars)
class ScaffoldMessengerModifier extends SingleChildStatelessModifier {
  /// Creates a widget that manages [SnackBar]s for [Scaffold] descendants.
  const ScaffoldMessengerModifier({
    super.key,
    super.modifierKey,
    super.child,
  });

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ScaffoldMessenger(
      key: modifierKey,
      child: child!,
    );
  }
}
