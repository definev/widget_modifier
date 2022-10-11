import 'package:flutter/material.dart';

import '../modifier.dart';

/// An inherited widget that defines the appearance of text selection in
/// this widget's subtree.
///
/// Values specified here are used for [TextField] and [SelectableText]
/// properties that are not given an explicit non-null value.
///
/// {@tool snippet}
///
/// Here is an example of a text selection theme that applies a blue cursor
/// color with light blue selection handles to the child text field.
///
/// ```dart
/// const TextSelectionTheme(
///   data: TextSelectionThemeData(
///     cursorColor: Colors.blue,
///     selectionHandleColor: Colors.lightBlue,
///   ),
///   child: TextField(),
/// )
/// ```
/// {@end-tool}
///
/// This widget also creates a [DefaultSelectionStyle] for its subtree with
/// [data].
class TextSelectionThemeModifier extends SingleChildStatelessModifier {
  /// Creates a text selection theme widget that specifies the text
  /// selection properties for all widgets below it in the widget tree.
  ///
  /// The data argument must not be null.
  const TextSelectionThemeModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.data,
  });

  /// The properties for descendant [TextField] and [SelectableText] widgets.
  final TextSelectionThemeData data;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return TextSelectionTheme(
      key: modifierKey,
      data: data,
      child: child!,
    );
  }
}
