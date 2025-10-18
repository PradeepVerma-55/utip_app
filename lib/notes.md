# Flutter & Dart Quick Reference

A short, practical help document covering BuildContext, Widgets, and an introduction to Dart classes & OOP. Designed for quick lookup and examples.

## Contents
- [BuildContext](#buildcontext)
- [Widgets](#widgets)
  - [StatelessWidget vs StatefulWidget](#statelesswidget-vs-statefulwidget)
  - [Tips & Patterns](#tips--patterns)
- [Dart Classes & Objects — Intro to OOP](#dart-classes--objects---intro-to-oop)
- [Quick Reference & Best Practices](#quick-reference--best-practices)

---

## BuildContext

What it is
- BuildContext represents the location of a widget within the widget tree.
- Each widget has a BuildContext and the framework passes it into `build(BuildContext context)`.

What you use it for
- Looking up inherited widgets: `Theme.of(context)`, `MediaQuery.of(context)`, `Localizations.of(...)`.
- Accessing context-based APIs: `Navigator.of(context)`, `ScaffoldMessenger.of(context)`, `Theme.of(context)`.
- Finding ancestors/descendants or using `context.findAncestorWidgetOfExactType(...)`.

Common pitfalls & tips
- Do not store a BuildContext to use later across async gaps — the tree can change.
- Avoid using `context` for inherited lookups directly in `initState`. Use `didChangeDependencies()` or schedule a post-frame callback:
  - `WidgetsBinding.instance.addPostFrameCallback((_) { ... });`
- In async callbacks inside a State, check `if (!mounted) return;` before using context.
- Use `Builder` to get a new inner context when needed (e.g., showing dialogs inside a build).

Example
```dart
// inside a widget's build
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  return Text('Hello', style: theme.textTheme.bodyMedium);
}
```

---

## Widgets

Definition
- Widgets are the building blocks of Flutter UI. Everything is a widget: layout, controls, styling.

StatelessWidget vs StatefulWidget
- StatelessWidget: immutable; rebuilds only when parent asks. Use for static or parameter-driven UI.
- StatefulWidget: has mutable state managed by a `State` object; useful when the UI changes over time.

Tips & patterns
- Prefer many small widgets over one large widget; composition improves readability and testability.
- Use `const` constructors when possible to reduce rebuild work.
- Use `Key`s to preserve identity when lists or order can change.
- Extract widgets to avoid deep build methods and to obtain fresh BuildContext for localized operations.

Example: small stateless widget
```dart
class Greeting extends StatelessWidget {
  final String name;
  const Greeting(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Hello, $name', style: Theme.of(context).textTheme.bodyMedium);
  }
}
```

---

## Dart classes & objects — Introduction to OOP

Core concepts
- Class: blueprint describing fields and behavior (methods).
- Object/Instance: concrete realization of a class.
- Encapsulation: use `_private` members to hide implementation.
- Inheritance: `extends` to reuse behavior; prefer composition for flexibility.
- Mixins/Interfaces: `with` and `implements` for reuse and contracts.

Constructors
- Dart supports default, named, and factory constructors.
- Use initializer lists for `final` fields: `MyClass(this.x) : assert(x != null);`

Example
```dart
class Person {
  final String name;
  int age;

  Person(this.name, this.age);

  void celebrateBirthday() => age += 1;

  @override
  String toString() => '$name, age $age';
}

class Student extends Person {
  final String school;
  Student(String name, int age, this.school) : super(name, age);
}

void main() {
  final s = Student('Alex', 20, 'U Academy');
  s.celebrateBirthday();
  print(s); // Alex, age 21
}
```

Practical OOP tips
- Favor immutability (`final`) when possible.
- Keep classes focused on a single responsibility.
- Prefer composition over deep inheritance chains.
- Use Dart’s null-safety and static typing to catch errors early.

---

## Quick Reference & Best Practices

- Layout spacing: use `Padding`, `SizedBox`, or `Container.padding` appropriately. Standalone `Padding` with no child is rarely useful — prefer `SizedBox` for explicit spacers.
- Use `mounted` in async callbacks to avoid using context when the widget is disposed.
- For context-dependent initialization, prefer `didChangeDependencies()` or post-frame callbacks instead of `initState`.
- Reuse theme values: `Theme.of(context)` and `Theme.of(context).textTheme`.
- Keep `build()` fast: move heavy work out of build and into state or other layers.

Further reading
- Flutter docs: https://flutter.dev/docs
- Effective Dart: https://dart.dev/guides/language/effective-dart

---
(If you'd like, I can also generate a printable PDF or README-styled `help.md` with the same contents.)
