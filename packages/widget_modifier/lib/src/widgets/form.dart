import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class FormModifier extends SingleChildStatelessModifier {
  const FormModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.onWillPop,
    this.onChanged,
    this.autovalidateMode,
  }) : super(key: key, child: child);

  final WillPopCallback? onWillPop;
  final VoidCallback? onChanged;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Form(
      key: modifierKey,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      onWillPop: onWillPop,
      child: child!,
    );
  }
}

typedef FormFieldModifierBuilder<T> = Widget Function(
  FormFieldState<T> field,
  Widget? child,
);

class FormFieldModifier<T> extends SingleChildStatelessModifier {
  const FormFieldModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.builder,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.enabled = true,
    AutovalidateMode? autovalidateMode,
    this.restorationId,
  })  : autovalidateMode = autovalidateMode ?? AutovalidateMode.disabled,
        super(key: key, child: child);

  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final FormFieldModifierBuilder<T> builder;
  final T? initialValue;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final String? restorationId;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return FormField<T>(
      key: modifierKey,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      initialValue: initialValue,
      onSaved: onSaved,
      restorationId: restorationId,
      validator: validator,
      builder: (field) => builder(field, child),
    );
  }
}
