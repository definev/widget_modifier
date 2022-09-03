import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class ListTileThemeModifier extends SingleChildStatelessModifier {
  const ListTileThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.data,
    this.dense,
    this.shape,
    this.style,
    this.selectedColor,
    this.iconColor,
    this.textColor,
    this.contentPadding,
    this.tileColor,
    this.selectedTileColor,
    this.enableFeedback,
    this.mouseCursor,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
  });

  final ListTileThemeData? data;
  final bool? dense;
  final ShapeBorder? shape;
  final ListTileStyle? style;
  final Color? selectedColor;
  final Color? iconColor;
  final Color? textColor;
  final EdgeInsetsGeometry? contentPadding;
  final Color? tileColor;
  final Color? selectedTileColor;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;
  final bool? enableFeedback;
  final MaterialStateProperty<MouseCursor?>? mouseCursor;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ListTileTheme(
      key: modifierKey,
      data: data,
      dense: dense,
      shape: shape,
      style: style,
      textColor: textColor,
      tileColor: tileColor,
      iconColor: iconColor,
      mouseCursor: mouseCursor,
      selectedColor: selectedColor,
      contentPadding: contentPadding,
      enableFeedback: enableFeedback,
      minLeadingWidth: minLeadingWidth,
      selectedTileColor: selectedTileColor,
      minVerticalPadding: minVerticalPadding,
      horizontalTitleGap: horizontalTitleGap,
      child: child!,
    );
  }
}
