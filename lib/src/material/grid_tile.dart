import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class GridTileModifier extends SingleChildStatelessWidget {
  const GridTileModifier({
    super.key,
    super.child,
    this.modifierKey,
    this.header,
    this.footer,
  });

  final Key? modifierKey;
  final Widget? header;
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
