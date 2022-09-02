import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

class AboutListTileModifier extends SingleChildStatelessWidget {
  const AboutListTileModifier({
    Key? key,
    Widget? child,
    this.modifierKey,
    this.icon,
    this.applicationName,
    this.applicationVersion,
    this.applicationIcon,
    this.applicationLegalese,
    this.aboutBoxChildren,
    this.dense,
  }) : super(key: key, child: child);

  final Key? modifierKey;
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
