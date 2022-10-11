import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines color and style parameters for [ListTile]s
/// in this widget's subtree.
///
/// Values specified here are used for [ListTile] properties that are not given
/// an explicit non-null value.
///
/// The [Drawer] widget specifies a tile theme for its children which sets
/// [style] to [ListTileStyle.drawer].
class ListTileThemeModifier extends SingleChildStatelessModifier {
  /// Creates a list tile theme that defines the color and style parameters for
  /// descendant [ListTile]s.
  ///
  /// Only the [data] parameter should be used. The other parameters are
  /// redundant (are now obsolete) and will be deprecated in a future update.
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

 
  /// The configuration of this theme.
  final ListTileThemeData? data;
  
  /// Overrides the default value of [ListTile.dense].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.dense] property instead.
  final bool? dense;
  
  /// Overrides the default value of [ListTile.shape].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.shape] property instead.
  final ShapeBorder? shape;
 
  /// Overrides the default value of [ListTile.style].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.style] property instead.
  final ListTileStyle? style;
  
  /// Overrides the default value of [ListTile.selectedColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.selectedColor] property instead.
  final Color? selectedColor;
 
  /// Overrides the default value of [ListTile.iconColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.iconColor] property instead.
  final Color? iconColor;
 
  /// Overrides the default value of [ListTile.textColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.textColor] property instead.
  final Color? textColor;
  
  /// Overrides the default value of [ListTile.contentPadding].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.contentPadding] property instead.
  final EdgeInsetsGeometry? contentPadding;
  
  /// Overrides the default value of [ListTile.tileColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.tileColor] property instead.
  final Color? tileColor;
  
  /// Overrides the default value of [ListTile.selectedTileColor].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.selectedTileColor] property instead.
  final Color? selectedTileColor;
  
  /// Overrides the default value of [ListTile.horizontalTitleGap].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.horizontalTitleGap] property instead.
  final double? horizontalTitleGap;
  
  /// Overrides the default value of [ListTile.minVerticalPadding].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.minVerticalPadding] property instead.
  final double? minVerticalPadding;
  
  /// Overrides the default value of [ListTile.minLeadingWidth].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.minLeadingWidth] property instead.
  final double? minLeadingWidth;
  
  /// Overrides the default value of [ListTile.enableFeedback].
  ///
  /// This property is obsolete: please use the [data]
  /// [ListTileThemeData.enableFeedback] property instead.
  final bool? enableFeedback;

  /// If specified, overrides the default value of [ListTile.mouseCursor].
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
