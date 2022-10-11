import 'package:flutter/material.dart';

import '../modifier.dart';

/// The top-most region of a Material Design drawer. The header's [child]
/// widget, if any, is placed inside a [Container] whose [decoration] can be
/// passed as an argument, inset by the given [padding].
///
/// Part of the Material Design [Drawer].
///
/// Requires one of its ancestors to be a [Material] widget. This condition is
/// satisfied by putting the [DrawerHeader] in a [Drawer].
///
/// See also:
///
///  * [UserAccountsDrawerHeader], a variant of [DrawerHeader] that is
///    specialized for showing user accounts.
///  * <https://material.io/design/components/navigation-drawer.html>
class DrawerHeaderModifier extends SingleChildStatelessModifier {
  /// Creates a Material Design drawer header.
  ///
  /// Requires one of its ancestors to be a [Material] widget.
  const DrawerHeaderModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.decoration,
    this.margin = const EdgeInsets.only(bottom: 8.0),
    this.padding = const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.fastOutSlowIn,
  });

 
  /// Decoration for the main drawer header [Container]; useful for applying
  /// backgrounds.
  ///
  /// This decoration will extend under the system status bar.
  ///
  /// If this is changed, it will be animated according to [duration] and [curve].
  final Decoration? decoration;

  /// The padding by which to inset [child].
  ///
  /// The [DrawerHeader] additionally offsets the child by the height of the
  /// system status bar.
  ///
  /// If the child is null, the padding has no effect.
  final EdgeInsetsGeometry padding;

  /// The margin around the drawer header.
  final EdgeInsetsGeometry? margin;

  /// The duration for animations of the [decoration].
  final Duration duration;

  /// The curve for animations of the [decoration].
  final Curve curve;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DrawerHeader(
      key: modifierKey,
      curve: curve,
      decoration: decoration,
      duration: duration,
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
