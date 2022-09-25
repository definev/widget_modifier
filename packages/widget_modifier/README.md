<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
<p align="center">
<img src="assets/icon.png" alt="logo" width="100" />
</p>

# Widget modifier

A collection of built-in flutter widget modifiers, which flatten the widget tree and make it easier to read.

---

## Problem

```dart
AspectRatio(
  aspectRatio: 16 / 8,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFe1e4e3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(),
    ),
  ),
)
```
This is a typical flutter widget. With **four** nested widgets, the code is pretty hard to read. Your eyes need to skim to `Padding`, `AspectRatio`, `DecoratedBox`, and `Padding` to reach out to the actual child widget. This process is unesscessary and consumes your brain's power to do.

Of course, no one in real-world do this. Instead of, we uses a big friendly (or maybe not) guy - `Container`. The previous widget becomes this

```dart
AspectRatio(
  aspectRatio: 16 / 8,
  child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: const Color(0xFFe1e4e3),
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(20),
    child: Row(),
  ),
)
```

But why we still have `AspectRatio` widget? Because `Container` doesn't have `aspectRatio` field. It's mean `Container` not flexible to provide all kind of configuraiton you needs.

To fix this `widget_modifier` introduces a new set of APIs to "flatten" your widget.

## Usage

Widget modifier have two API styles: `declarative` and `cascading`

#### Declarative

Declarative modifier version of the above example widget

```dart
Modifier(
  modifiers: [
    AspectRatioModifier(
      aspectRatio: 16 / 8,
    ),
    PaddingModifier(
      padding: const EdgeInsets.symmetric(horizontal: 20),
    ),
    DecoratedBoxModifier(
      decoration: BoxDecoration(
        color: const Color(0xFFe1e4e3),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    PaddingModifier(
      padding: const EdgeInsets.all(20),
    )
  ],
  child: Row(),
),

```


- `modifiers`: a `List<SingleChildModifier>` basically the wrapper for typical `Widget` which have one child
- `child`: child of `Modifer`


Declarative modifier will apply from bottom element to top element of the `modifiers` list 

##### Pros & Cons

Pros:
- Easy to detect where the root `child` widget
- Follow composition

Cons:
- Counter-intuitive at first

#### Cascading
Cascading modifier version of the above example widget

```dart
Row()
  .modified()
  .add(PaddingModifier(
    padding: const EdgeInsets.all(20),
  ))
  .add(DecoratedBoxModifier(
    decoration: BoxDecoration(
      color: const Color(0xFFe1e4e3),
      borderRadius: BorderRadius.circular(20),
    ),
  ))
  .add(PaddingModifier(
    padding: const EdgeInsets.symmetric(horizontal: 20),
  ))
  .add(AspectRatioModifier(
    aspectRatio: 16 / 8,
  ))
```

- `modified()`: extenstion turn your widget to `Modifier`
- `add()`: insert `SingleChildModifier` to the beginning of the `modifiers` list
- `addAll()`: insert `List<SingleChildModifier>` to the beginning of the `modifiers` list

Cascading modifier will apply from top `add`/`addAll` element to bottom. 

## Custom

If you want to make a custom modifier check out `SingleChildStatelessModifier`/`SingleChildStatefulModifier` equalvalents version `StatelessWidget`/`StatefulWidget`

#### Caution
⚠️ You need to override `buildWithChild` insteads of `build` method
⚠️ `buildWithChild` like `build` but have another `child` parameter which is the widget `Modifier` give to `SingleChildModifer`
⚠️ `modifierKey` is the key of actual widget inside modifier

### SingleChildStatelessModifier
```dart
class ConstrainedBoxModifier extends SingleChildStatelessModifier {
  ConstrainedBoxModifier({
    Key? key,
    Widget? child,
    super.modifierKey,
    required this.constraints,
  })  : assert(constraints.debugAssertIsValid()),
        super(key: key, child: child);

  final BoxConstraints constraints;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ConstrainedBox(
      key: modifierKey,
      constraints: constraints,
      child: child,
    );
  }
}
```

### SingleChildStatefulModifier
You need to implements `SingleChildStateMixin` mixin in `State` class of `SingleChildStatefulModifier`

```dart
class StatefulBuilderModifier extends SingleChildStatefulModifier {
  const StatefulBuilderModifier({
    super.key,
    super.modifierKey,
    required this.builder,
  });

  final SingleChildStatefulWidgetBuilder builder;

  @override
  State<StatefulWidget> createState() => _StatefulBuilderModifierState();
}

class _StatefulBuilderModifierState extends State<StatefulBuilderModifier>
    with SingleChildStateMixin<StatefulBuilderModifier> {
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return widget.builder(context, setState, child);
  }
}
```