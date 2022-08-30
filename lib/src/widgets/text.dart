import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

class DefaultTextStyleModifier extends SingleChildStatelessWidget {
  const DefaultTextStyleModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.style,
    this.textAlign,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  }) : super(key: key, child: child);

  static Widget merge({
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
    return Builder(
      builder: (BuildContext context) {
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

  final Key? modifierKey;
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

class DefaultTextHeightBehaviorModifier extends SingleChildStatelessWidget {
  const DefaultTextHeightBehaviorModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    required this.textHeightBehavior,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
