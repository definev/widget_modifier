import 'package:flutter/material.dart';
import '../modifier.dart';

/// An inherited widget that defines the configuration for
/// [MaterialBanner]s in this widget's subtree.
///
/// Values specified here are used for [MaterialBanner] properties that are not
/// given an explicit non-null value.
class MaterialBannerThemeModifier extends SingleChildStatelessModifier {
  /// Creates a banner theme that controls the configurations for
  /// [MaterialBanner]s in its widget subtree.
  const MaterialBannerThemeModifier({
    super.key,
    super.modifierKey,
    super.child,
    this.data,
  });

  /// The properties for descendant [MaterialBanner] widgets.
  final MaterialBannerThemeData? data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MaterialBannerTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
