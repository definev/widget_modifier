import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../modifier.dart';

/// A widget whose content stays synced with a [ValueListenable].
///
/// Given a [ValueListenable<T>] and a [builder] which builds widgets from
/// concrete values of `T`, this class will automatically register itself as a
/// listener of the [ValueListenable] and call the [builder] with updated values
/// when the value changes.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=s-ZG-jS5QHQ}
///
/// ## Performance optimizations
///
/// If your [builder] function contains a subtree that does not depend on the
/// value of the [ValueListenable], it's more efficient to build that subtree
/// once instead of rebuilding it on every animation tick.
///
/// If you pass the pre-built subtree as the [child] parameter, the
/// [ValueListenableBuilder] will pass it back to your [builder] function so
/// that you can incorporate it into your build.
///
/// Using this pre-built child is entirely optional, but can improve
/// performance significantly in some cases and is therefore a good practice.
///
/// {@tool snippet}
///
/// This sample shows how you could use a [ValueListenableBuilder] instead of
/// setting state on the whole [Scaffold] in the default `flutter create` app.
///
/// ```dart
/// class MyHomePage extends StatefulWidget {
///   const MyHomePage({super.key, required this.title});
///   final String title;
///
///   @override
///   State<MyHomePage> createState() => _MyHomePageState();
/// }
///
/// class _MyHomePageState extends State<MyHomePage> {
///   final ValueNotifier<int> _counter = ValueNotifier<int>(0);
///   final Widget goodJob = const Text('Good job!');
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(
///         title: Text(widget.title)
///       ),
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: <Widget>[
///             const Text('You have pushed the button this many times:'),
///             ValueListenableBuilder<int>(
///               builder: (BuildContext context, int value, Widget? child) {
///                 // This builder will only get called when the _counter
///                 // is updated.
///                 return Row(
///                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
///                   children: <Widget>[
///                     Text('$value'),
///                     child!,
///                   ],
///                 );
///               },
///               valueListenable: _counter,
///               // The child parameter is most helpful if the child is
///               // expensive to build and does not depend on the value from
///               // the notifier.
///               child: goodJob,
///             )
///           ],
///         ),
///       ),
///       floatingActionButton: FloatingActionButton(
///         child: const Icon(Icons.plus_one),
///         onPressed: () => _counter.value += 1,
///       ),
///     );
///   }
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedBuilder], which also triggers rebuilds from a [Listenable]
///    without passing back a specific value from a [ValueListenable].
///  * [NotificationListener], which lets you rebuild based on [Notification]
///    coming from its descendant widgets rather than a [ValueListenable] that
///    you have a direct reference to.
///  * [StreamBuilder], where a builder can depend on a [Stream] rather than
///    a [ValueListenable] for more advanced use cases.
class ValueListenableBuilderModifier<T> extends SingleChildStatelessModifier {
  /// Creates a [ValueListenableBuilder].
  ///
  /// The [valueListenable] and [builder] arguments must not be null.
  /// The [child] is optional but is good practice to use if part of the widget
  /// subtree does not depend on the value of the [valueListenable].
  const ValueListenableBuilderModifier({
    super.key,
    super.child,
    super.modifierKey,
    required this.valueListenable,
    required this.builder,
  });

  /// The [ValueListenable] whose value you depend on in order to build.
  ///
  /// This widget does not ensure that the [ValueListenable]'s value is not
  /// null, therefore your [builder] may need to handle null values.
  ///
  /// This [ValueListenable] itself must not be null.
  final ValueListenable<T> valueListenable;

  /// A [ValueWidgetBuilder] which builds a widget depending on the
  /// [valueListenable]'s value.
  ///
  /// Can incorporate a [valueListenable] value-independent widget subtree
  /// from the [child] parameter into the returned widget tree.
  ///
  /// Must not be null.
  final ValueWidgetBuilder<T> builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ValueListenableBuilder<T>(
      key: modifierKey,
      valueListenable: valueListenable,
      builder: builder,
      child: child,
    );
  }
}
