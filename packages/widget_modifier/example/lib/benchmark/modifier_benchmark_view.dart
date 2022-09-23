import 'dart:async';

import 'package:widget_modifier/widgets.dart';
import 'package:flutter/material.dart';

/// BENCHMARK RESULT:
/// Depth layer : 1489
class ModifierBenchmarkView extends StatefulWidget {
  const ModifierBenchmarkView({super.key});

  @override
  State<ModifierBenchmarkView> createState() => _ModifierBenchmarkViewState();
}

class _ModifierBenchmarkViewState extends State<ModifierBenchmarkView> {
  late Timer timer;

  final List<SingleChildModifier> _children = [const SizedBoxModifier()];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (t) {
        _children.add(const SizedBoxModifier());
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Modifier(
        modifiers: _children,
        child: Text('Total layer of widget : ${_children.length}'),
      );
    } catch (e) {
      timer.cancel();
      return Text('LIMIT : ${_children.length}');
    }
  }
}
