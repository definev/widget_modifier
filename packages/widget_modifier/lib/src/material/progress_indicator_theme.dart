import 'package:flutter/material.dart';

import '../../material.dart';

/// An inherited widget that defines the configuration for
/// [ProgressIndicator]s in this widget's subtree.
///
/// Values specified here are used for [ProgressIndicator] properties that are not
/// given an explicit non-null value.
///
/// {@tool snippet}
///
/// Here is an example of a progress indicator theme that applies a red indicator
/// color.
///
/// ```dart
/// const ProgressIndicatorTheme(
///   data: ProgressIndicatorThemeData(
///     color: Colors.red,
///   ),
///   child: LinearProgressIndicator()
/// )
/// ```
/// {@end-tool}
class ProgressIndicatorThemeModifier extends SingleChildStatelessModifier {
  /// Creates a theme that controls the configurations for [ProgressIndicator]
  /// widgets.
  const ProgressIndicatorThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties for descendant [ProgressIndicator] widgets.
  final ProgressIndicatorThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ProgressIndicatorTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
