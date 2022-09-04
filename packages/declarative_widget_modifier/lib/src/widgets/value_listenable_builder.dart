import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ValueListenableBuilderModifier<T> extends SingleChildStatelessModifier {
  const ValueListenableBuilderModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.valueListenable,
    required this.builder,
  }) : super(key: key, child: child);

  final ValueListenable<T> valueListenable;
  final ValueWidgetBuilder<T> builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ValueListenableBuilder(
      key: modifierKey,
      valueListenable: valueListenable,
      builder: builder,
      child: child,
    );
  }
}
