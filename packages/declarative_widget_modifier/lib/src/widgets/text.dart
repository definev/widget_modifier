import 'dart:ui' as ui;

import 'package:declarative_widget_modifier/src/modifier.dart';
import 'package:declarative_widget_modifier/src/widgets/basic.dart';
import 'package:flutter/widgets.dart';

class DefaultTextStyleModifier extends SingleChildStatelessModifier {
  const DefaultTextStyleModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  }) : super(key: key, child: child);

  static SingleChildModifier merge({
    Key? key,
    Widget? child,
    Key? modifierKey,
    TextStyle? style,
    TextAlign? textAlign,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    TextWidthBasis? textWidthBasis,
  }) {
    return BuilderModifier(
      builder: (BuildContext context, Widget? child) {
        final DefaultTextStyle parent = DefaultTextStyle.of(context);
        return DefaultTextStyleModifier(
          key: key,
          modifierKey: modifierKey,
          style: parent.style.merge(style),
          textAlign: textAlign ?? parent.textAlign,
          softWrap: softWrap ?? parent.softWrap,
          overflow: overflow ?? parent.overflow,
          maxLines: maxLines ?? parent.maxLines,
          textWidthBasis: textWidthBasis ?? parent.textWidthBasis,
          child: child!,
        );
      },
    );
  }

  final TextStyle style;
  final TextAlign? textAlign;
  final bool softWrap;
  final TextOverflow overflow;
  final int? maxLines;
  final TextWidthBasis textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTextStyle(
      key: modifierKey,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      child: child!,
    );
  }
}

class DefaultTextHeightBehaviorModifier extends SingleChildStatelessModifier {
  const DefaultTextHeightBehaviorModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.textHeightBehavior,
  }) : super(key: key, child: child);

  final TextHeightBehavior textHeightBehavior;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return DefaultTextHeightBehavior(
      key: modifierKey,
      textHeightBehavior: textHeightBehavior,
      child: child!,
    );
  }
}
