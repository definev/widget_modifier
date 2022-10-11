import 'package:flutter/material.dart';

import '../modifier.dart';

/// An optional container for grouping together multiple form field widgets
/// (e.g. [TextField] widgets).
///
/// Each individual form field should be wrapped in a [FormField] widget, with
/// the [Form] widget as a common ancestor of all of those. Call methods on
/// [FormState] to save, reset, or validate each [FormField] that is a
/// descendant of this [Form]. To obtain the [FormState], you may use [Form.of]
/// with a context whose ancestor is the [Form], or pass a [GlobalKey] to the
/// [Form] constructor and call [GlobalKey.currentState].
///
/// {@tool dartpad}
/// This example shows a [Form] with one [TextFormField] to enter an email
/// address and an [ElevatedButton] to submit the form. A [GlobalKey] is used here
/// to identify the [Form] and validate input.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)
///
/// ** See code in examples/api/lib/widgets/form/form.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [GlobalKey], a key that is unique across the entire app.
///  * [FormField], a single form field widget that maintains the current state.
///  * [TextFormField], a convenience widget that wraps a [TextField] widget in a [FormField].
class FormModifier extends SingleChildStatelessModifier {
  /// Creates a container for form fields.
  ///
  /// The [child] argument must not be null.
  const FormModifier({
    super.key,
    super.child,
    super.modifierKey,
    this.onWillPop,
    this.onChanged,
    this.autovalidateMode,
  });

  /// Enables the form to veto attempts by the user to dismiss the [ModalRoute]
  /// that contains the form.
  ///
  /// If the callback returns a Future that resolves to false, the form's route
  /// will not be popped.
  ///
  /// See also:
  ///
  ///  * [WillPopScope], another widget that provides a way to intercept the
  ///    back button.
  final WillPopCallback? onWillPop;

  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked, all the form fields themselves
  /// will rebuild.
  final VoidCallback? onChanged;

  /// Used to enable/disable form fields auto validation and update their error
  /// text.
  ///
  /// {@macro flutter.widgets.FormField.autovalidateMode}
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

/// Signature for building the widget representing the form field.
///
/// Used by [FormField.builder].
typedef FormFieldModifierBuilder<T> = Widget Function(
  FormFieldState<T> field,
  Widget? child,
);

/// A single form field.
///
/// This widget maintains the current state of the form field, so that updates
/// and validation errors are visually reflected in the UI.
///
/// When used inside a [Form], you can use methods on [FormState] to query or
/// manipulate the form data as a whole. For example, calling [FormState.save]
/// will invoke each [FormField]'s [onSaved] callback in turn.
///
/// Use a [GlobalKey] with [FormField] if you want to retrieve its current
/// state, for example if you want one form field to depend on another.
///
/// A [Form] ancestor is not required. The [Form] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
///
/// See also:
///
///  * [Form], which is the widget that aggregates the form fields.
///  * [TextField], which is a commonly used form field for entering text.
class FormFieldModifier<T> extends SingleChildStatelessModifier {
  /// Creates a single form field.
  ///
  /// The [builder] argument must not be null.
  const FormFieldModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.builder,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.enabled = true,
    AutovalidateMode? autovalidateMode,
    this.restorationId,
  }) : autovalidateMode = autovalidateMode ?? AutovalidateMode.disabled;

  /// An optional method to call with the final value when the form is saved via
  /// [FormState.save].
  final FormFieldSetter<T>? onSaved;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property.
  /// The [TextFormField] uses this to override the [InputDecoration.errorText]
  /// value.
  ///
  /// Alternating between error and normal state can cause the height of the
  /// [TextFormField] to change if no other subtext decoration is set on the
  /// field. To create a field whose height is fixed regardless of whether or
  /// not an error is displayed, either wrap the  [TextFormField] in a fixed
  /// height parent like [SizedBox], or set the [InputDecoration.helperText]
  /// parameter to a space.
  final FormFieldValidator<T>? validator;

  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final FormFieldModifierBuilder<T> builder;

  /// An optional value to initialize the form field to, or null otherwise.
  final T? initialValue;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidateMode] is not [AutovalidateMode.disabled],
  /// the field will be auto validated. Likewise, if this field is false, the widget
  /// will not be validated regardless of [autovalidateMode].
  final bool enabled;

  /// Used to enable/disable this form field auto validation and update its
  /// error text.
  ///
  /// {@template flutter.widgets.FormField.autovalidateMode}
  /// If [AutovalidateMode.onUserInteraction], this FormField will only
  /// auto-validate after its content changes. If [AutovalidateMode.always], it
  /// will auto-validate even without user interaction. If
  /// [AutovalidateMode.disabled], auto-validation will be disabled.
  ///
  /// Defaults to [AutovalidateMode.disabled], cannot be null.
  /// {@endtemplate}
  final AutovalidateMode autovalidateMode;

  /// Restoration ID to save and restore the state of the form field.
  ///
  /// Setting the restoration ID to a non-null value results in whether or not
  /// the form field validation persists.
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
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
      builder: (FormFieldState<T> field) => builder(field, child),
    );
  }
}
