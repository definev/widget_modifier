import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/widgets.dart';

class WidgetInspectorModifier extends SingleChildStatelessModifier {
  const WidgetInspectorModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.selectButtonBuilder,
  }) : super(key: key, child: child);

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
