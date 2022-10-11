import 'package:flutter/material.dart';

import '../modifier.dart';

/// A tile in a Material Design grid list.
///
/// A grid list is a [GridView] of tiles in a vertical and horizontal
/// array. Each tile typically contains some visually rich content (e.g., an
/// image) together with a [GridTileBar] in either a [header] or a [footer].
///
/// See also:
///
///  * [GridView], which is a scrollable grid of tiles.
///  * [GridTileBar], which is typically used in either the [header] or
///    [footer].
///  * <https://material.io/design/components/image-lists.html>
class GridTileModifier extends SingleChildStatelessModifier {
  /// Creates a grid tile.
  ///
  /// Must have a child. Does not typically have both a header and a footer.
  const GridTileModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.header,
    this.footer,
  });


  /// The widget to show over the top of this grid tile.
  ///
  /// Typically a [GridTileBar].
  final Widget? header;

  /// The widget to show over the bottom of this grid tile.
  ///
  /// Typically a [GridTileBar].
  final Widget? footer;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return GridTile(
      key: modifierKey,
      footer: footer,
      header: header,
      child: child!,
    );
  }
}
