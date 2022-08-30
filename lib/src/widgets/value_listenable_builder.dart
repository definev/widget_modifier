import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class ValueListenableBuilderModifier<T> extends SingleChildStatelessWidget {
  const ValueListenableBuilderModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.valueListenable,
    required this.builder,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
