import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class GridTileModifier extends SingleChildStatelessModifier {
  const GridTileModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.header,
    this.footer,
  });

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
