import 'dart:async';

import 'package:flutter/material.dart';

/// BENCHMARK RESULT:
/// Depth layer : 1489
class BenchmarkView extends StatefulWidget {
  const BenchmarkView({super.key});

  @override
  State<BenchmarkView> createState() => _BenchmarkViewState();
}

class _BenchmarkViewState extends State<BenchmarkView> {
  late Timer timer;

  int total = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (t) {
        total += 1;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      Widget widget = Text('Total layer of widget : $total');

      for (int i = 0; i < total; i++) {
        widget = SizedBox(child: widget);
      }
      return widget;
    } catch (e) {
      timer.cancel();
      return Text('LIMIT : $total');
    }
  }
}
