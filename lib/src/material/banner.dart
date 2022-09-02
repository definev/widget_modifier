import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class MaterialBannerModifier extends SingleChildStatelessWidget {
  const MaterialBannerModifier({
    Key? key,
    Widget? content,
    this.modifierKey,
    this.contentTextStyle,
    required this.actions,
    this.elevation,
    this.leading,
    this.backgroundColor,
    this.padding,
    this.leadingPadding,
    this.forceActionsBelow = false,
    this.overflowAlignment = OverflowBarAlignment.end,
    this.animation,
    this.onVisible,
  }) : super(key: key, child: content);

  final Key? modifierKey;
  final TextStyle? contentTextStyle;
  final List<Widget> actions;
  final double? elevation;
  final Widget? leading;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? leadingPadding;
  final bool forceActionsBelow;
  final OverflowBarAlignment overflowAlignment;
  final Animation<double>? animation;
  final VoidCallback? onVisible;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MaterialBanner(
      key: modifierKey,
      animation: animation,
      backgroundColor: backgroundColor,
      contentTextStyle: contentTextStyle,
      elevation: elevation,
      forceActionsBelow: forceActionsBelow,
      leading: leading,
      leadingPadding: leadingPadding,
      onVisible: onVisible,
      overflowAlignment: overflowAlignment,
      padding: padding,
      actions: actions,
      content: child!,
    );
  }
}
