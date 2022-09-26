

<p align="center">
<img src="assets/banner.png" alt="logo" width="300" />
</p>


A collection of built-in flutter widget modifiers, which flatten the widget tree and make it easier to read.

Credit: Original idea and the `widget_modifier` base code is a modified version of [`nested`](https://pub.dev/packages/nested) widget by [@remi_rousselet](https://github.com/rrousselGit)

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
This is a typical flutter widget. With **four** nested widgets, the code is pretty hard to read. Your eyes need to skim to `Padding`, `AspectRatio`, `DecoratedBox`, and `Padding` to reach out to the actual child widget. This process is unnecessary and consumes your brain's power to do.

Of course, no one in the real world does this. Instead, we use a big friendly (or maybe not) guy - `Container`. The previous widget becomes this.

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

But why do we still have `AspectRatio` widget? Because `Container` doesn't have `aspectRatio` field. It means `Container` is not flexible to provide all kinds of configurations you need.

To fix this, `widget_modifier` introduces a new set of APIs to "flatten" your widget.


## Usage

Widget modifier have two API styles: `declarative` and `cascading`

### Declarative

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


- `modifiers`: a `List<SingleChildModifier>` basically the wrapper for a typical `Widget` which has one child
- `child`: child of `Modifer`



The declarative modifier will apply from the bottom element to the top element of the `modifiers` list. 

#### Pros & Cons

Pros:
- Easy to detect where the root `child` widget
- Nice code format
- Work well with editor code folding

Cons:
- Counter-intuitive at first

### Cascading
Cascading modifier version of the above example widget

```dart
Row()
  .modified()
  .wrapWith(PaddingModifier(
    padding: const EdgeInsets.all(20),
  ))
  .wrapWith(DecoratedBoxModifier(
    decoration: BoxDecoration(
      color: const Color(0xFFe1e4e3),
      borderRadius: BorderRadius.circular(20),
    ),
  ))
  .wrapWith(PaddingModifier(
    padding: const EdgeInsets.symmetric(horizontal: 20),
  ))
  .wrapWith(AspectRatioModifier(
    aspectRatio: 16 / 8,
  ))
```

- `modified()`: extenstion turn your widget to `Modifier`
- `wrapWith()`: insert `SingleChildModifier` to the beginning of the `modifiers` list
- `wrapWithAll()`: insert `List<SingleChildModifier>` to the beginning of the `modifiers` list

The cascading modifier will apply from the top `wrapWith`/`wrapWithAll` element to the bottom.

#### Pros & Cons
Pros:
- Easy to detect where the root `child` widget
- Intuitive to read

Cons:
- Code format is sometimes ugly

## Custom modifier

If you want to make a custom modifier check out `SingleChildStatelessModifier`/`SingleChildStatefulModifier` equivalents version `StatelessWidget`/`StatefulWidget`

#### Caution
⚠️ You need to override `buildWithChild` instead of `build` method

⚠️ `buildWithChild` is like `build` but has another `child` parameter which is the widget `Modifier` given to `SingleChildModifer`

⚠️ `modifierKey` is the key of the actual widget inside the modifier

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
## Editor support

You can easily convert existing widget to `Modifier` with my extension. See more at:

- [vscode](https://marketplace.visualstudio.com/items?itemName=definev.flutter-widget-modifier)

<img src="https://raw.githubusercontent.com/definev/widget_modifier/main/extensions/vscode/assets/convert-to-declarative.gif" width=650 />
