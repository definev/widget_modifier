import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

typedef SingleChildAutocompleteOptionsViewBuilder<T extends Object> = Widget
    Function(
  BuildContext context,
  AutocompleteOnSelected<T> onSelected,
  Iterable<T> options,
  Widget? child,
);

class RawAutocompleteModifier<T extends Object>
    extends SingleChildStatelessWidget {
  const RawAutocompleteModifier({
    super.key,
    this.modifierKey,
    required this.optionsViewBuilder,
    required this.optionsBuilder,
    this.displayStringForOption = defaultStringForOption,
    this.fieldViewBuilder,
    this.focusNode,
    this.onSelected,
    this.textEditingController,
    this.initialValue,
  });

  final Key? modifierKey;
  final AutocompleteFieldViewBuilder? fieldViewBuilder;
  final FocusNode? focusNode;
  final SingleChildAutocompleteOptionsViewBuilder<T> optionsViewBuilder;
  final AutocompleteOptionToString<T> displayStringForOption;
  final AutocompleteOnSelected<T>? onSelected;
  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final TextEditingController? textEditingController;
  final TextEditingValue? initialValue;

  static String defaultStringForOption(dynamic option) {
    return option.toString();
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return RawAutocomplete<T>(
      key: modifierKey,
      optionsViewBuilder: (context, onSelected, options) =>
          optionsViewBuilder(context, onSelected, options, child),
      optionsBuilder: optionsBuilder,
      displayStringForOption: displayStringForOption,
      fieldViewBuilder: fieldViewBuilder,
      focusNode: focusNode,
      initialValue: initialValue,
      onSelected: onSelected,
      textEditingController: textEditingController,
    );
  }
}

class AutocompleteHighlightedOptionModifier extends SingleChildStatelessWidget {
  const AutocompleteHighlightedOptionModifier({
    super.key,
    required this.highlightIndexNotifier,
    required super.child,
  });

  final ValueNotifier<int> highlightIndexNotifier;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AutocompleteHighlightedOption(
      highlightIndexNotifier: highlightIndexNotifier,
      child: child!,
    );
  }
}
