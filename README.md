# X Paginator

A simple and flexible package for Flutter to implement pagination in your applications.

## Installation

Add `x_paginator` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  x_paginator: ^1.0.0
```

## Usage

Import the package:

```dart
import 'package:x_paginator/x_paginator.dart';
```

Use the `XPaginator` widget to display your data:

```dart
XPaginator(
  fetchPage: (page) async {
    // Fetch data for the given page.
    // Return a list of items for this page.
  },
  itemBuilder: (item) {
    // Build a widget to display the item.
    return ListTile(
      title: Text(item.title),
      subtitle: Text(item.subtitle),
      leading: Icon(Icons.star),
    );
  },
),
```

For more advanced usage, see the `example` directory.

## Contributing

Contributions are welcome! Please open an issue or pull request on GitHub.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).