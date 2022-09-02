import 'dart:async';

import 'package:flutter/material.dart';

/// BENCHMARK:
/// - Layer depth : 1400
class ComplexBenchmarkView extends StatefulWidget {
  const ComplexBenchmarkView({super.key});

  @override
  State<ComplexBenchmarkView> createState() => _ComplexBenchmarkViewState();
}

class _ComplexBenchmarkViewState extends State<ComplexBenchmarkView> {
  int total = 0;

  Widget _baseLayer(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFffd2dd),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: IntrinsicHeight(
              child: child,
            ),
          ),
        ),
      ),
    );
  }

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
        total += 1;
        print(total * 5);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    try {
      Widget child = const SizedBox();

      for (int i = 0; i < total; i++) {
        child = _baseLayer(child);
      }

      return Stack(
        children: [
          Positioned.fill(child: child),
          Text(
            'LAYER : $total',
            style: theme.textTheme.headlineLarge,
          ),
        ],
      );
    } catch (e) {
      cancelled = true;
      return Text(
        'LAYER : $total',
        style: theme.textTheme.headlineLarge,
      );
    }
  }
}
