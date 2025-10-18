What is BuildContext?

- Definition
  - BuildContext is an object that represents the location of a widget within the widget tree.
  - Every widget has a BuildContext and the framework passes it into the `build(BuildContext context)` method.

- What it's for
  - Looking up inherited widgets (e.g., Theme, MediaQuery, Localizations).
  - Accessing Navigator, ScaffoldMessenger, and other context-dependent APIs: `Navigator.of(context)`, `ScaffoldMessenger.of(context)`, `Theme.of(context)`, etc.
  - Finding ancestor or descendant widgets.

- Common pitfalls & tips
  - Do not store a BuildContext to use later across async gaps; the tree may change. Prefer passing data or using state management.
  - Avoid using `context` for inherited lookups in `initState`. Use `didChangeDependencies()` or schedule a post-frame callback:
    - Use `WidgetsBinding.instance.addPostFrameCallback(...)` if you must access context after init.
  - Check `mounted` before using context inside async callbacks in a State object.

- Quick examples
  - Inside `build`:
    ```dart
    Widget build(BuildContext context) {
      final theme = Theme.of(context);
      return Text('Hello', style: theme.textTheme.bodyMedium);
    }
    ```
  - Navigating:
    ```dart
    ElevatedButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => NextPage())),
      child: const Text('Next'),
    );
    ```
  - If you need a fresh inner context (for example to show a dialog from a widget that is itself building a new subtree), use `Builder`:
    ```dart
    Builder(
      builder: (innerContext) {
        return ElevatedButton(
          onPressed: () => showDialog(context: innerContext, builder: (_) => const AlertDialog(title: Text('Hi'))),
          child: const Text('Show'),
        );
      },
    );
    ```
