import 'package:widget_modifier/src/modifier.dart';
import 'package:flutter/material.dart';

class AboutListTileModifier extends SingleChildStatelessModifier {
  const AboutListTileModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    this.icon,
    this.applicationName,
    this.applicationVersion,
    this.applicationIcon,
    this.applicationLegalese,
    this.aboutBoxChildren,
    this.dense,
  }) : super(key: key, child: child);

  final Widget? icon;
  final String? applicationName;
  final String? applicationVersion;
  final Widget? applicationIcon;
  final String? applicationLegalese;
  final List<Widget>? aboutBoxChildren;
  final bool? dense;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return AboutListTile(
      aboutBoxChildren: aboutBoxChildren,
      applicationIcon: applicationIcon,
      applicationLegalese: applicationLegalese,
      applicationName: applicationName,
      applicationVersion: applicationVersion,
      dense: dense,
      icon: icon,
      child: child,
    );
  }
}
