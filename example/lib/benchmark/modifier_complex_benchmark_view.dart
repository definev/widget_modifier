import 'dart:async';

import 'package:declarative_widget_modifier/widgets.dart';
import 'package:flutter/material.dart';

/// BENCHMARK:
/// - Layer depth : 1401
class ModifierComplexBenchmarkView extends StatefulWidget {
  const ModifierComplexBenchmarkView({super.key});

  @override
  State<ModifierComplexBenchmarkView> createState() =>
      _ModifierComplexBenchmarkViewState();
}

class _ModifierComplexBenchmarkViewState
    extends State<ModifierComplexBenchmarkView> {
  final _children = [
    const InteractiveViewerModifier(),
    const PaddingModifier(padding: EdgeInsets.only(top: 30)),
    const AspectRatioModifier(aspectRatio: 16 / 9),
    DecoratedBoxModifier(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFffd2dd),
      ),
    ),
    const PaddingModifier(
      padding: EdgeInsets.all(20),
    ),
    const IntrinsicHeightModifier(),
  ];
  final _baseLayer = [
    const PaddingModifier(padding: EdgeInsets.only(top: 30)),
    const AspectRatioModifier(aspectRatio: 16 / 9),
    DecoratedBoxModifier(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFffd2dd),
      ),
    ),
    const PaddingModifier(
      padding: EdgeInsets.all(20),
    ),
    const IntrinsicHeightModifier(),
  ];

  late Timer timer;
  bool cancelled = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) {
        if (cancelled) {
          timer.cancel();
          return;
        }
        _children.addAll(_baseLayer);
        print(_children.length);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    try {
      return Stack(
        children: [
          Positioned.fill(
            child: Modifier(
              modifiers: _children,
              child: const SizedBox(),
            ),
          ),
          Text(
            'LAYER : ${_children.length}',
            style: theme.textTheme.headlineLarge,
          ),
        ],
      );
    } catch (e) {
      cancelled = true;
      return Text(
        'LAYER : ${_children.length}',
        style: theme.textTheme.headlineLarge,
      );
    }
  }
}
