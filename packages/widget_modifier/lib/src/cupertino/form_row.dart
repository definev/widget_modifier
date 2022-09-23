import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/cupertino.dart';

class CupertinoFormRowModifier extends SingleChildStatelessModifier {
  const CupertinoFormRowModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.prefix,
    this.padding,
    this.helper,
    this.error,
  });

  final Widget? prefix;
  final EdgeInsetsGeometry? padding;
  final Widget? helper;
  final Widget? error;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return CupertinoFormRow(
      key: modifierKey,
      error: error,
      helper: helper,
      padding: padding,
      prefix: prefix,
      child: child!,
    );
  }
}
