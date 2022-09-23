// ignore_for_file: unused_import
import 'package:example/benchmark/benchmark_view.dart';
import 'package:example/benchmark/complex_benchmark_view.dart';
import 'package:example/benchmark/modifier_complex_benchmark_view.dart';
import 'package:example/benchmark/modifier_benchmark_view.dart';
import 'package:example/homework_reminder_ui/home_view.dart';
import 'package:example/homework_reminder_ui/modifier_home_view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FlexColorScheme.light(
      scheme: FlexScheme.amber,
      useMaterial3: true,
    ).toTheme;
    final darkTheme = FlexColorScheme.dark(
      scheme: FlexScheme.amber,
      useMaterial3: true,
    ).toTheme;

    return MaterialApp(
      title: 'Homework tracker',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const HomeView(),
      // home: const ModifierHomeView(),
      // home: const ModifierBenchmarkView(),
      // home: const BenchmarkView(),
      // home: const ModifierComplexBenchmarkView(),
      // home: const ComplexBenchmarkView(),
    );
  }
}
