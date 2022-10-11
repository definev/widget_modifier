import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget that visualizes the semantics for the child.
///
/// This widget is useful for understand how an app presents itself to
/// accessibility technology.
class SemanticsDebuggerModifier extends SingleChildStatelessModifier {
  /// Creates a widget that visualizes the semantics for the child.
  ///
  /// The [child] argument must not be null.
  ///
  /// [labelStyle] dictates the [TextStyle] used for the semantics labels.
  const SemanticsDebuggerModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.labelStyle = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 10.0,
      height: 0.8,
    ),
  });

  /// The [TextStyle] to use when rendering semantics labels.
  final TextStyle labelStyle;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return SemanticsDebugger(
      key: modifierKey,
      labelStyle: labelStyle,
      child: child!,
    );
  }
}
