import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class WidgetInspectorModifier extends SingleChildStatelessWidget {
  const WidgetInspectorModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.selectButtonBuilder,
  }) : super(key: key, child: child);

  final Key? modifierKey;
  final InspectorSelectButtonBuilder? selectButtonBuilder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return WidgetInspector(
      key: modifierKey,
      selectButtonBuilder: selectButtonBuilder,
      child: child!,
    );
  }
}
