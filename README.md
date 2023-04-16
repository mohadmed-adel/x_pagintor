X Paginator
X Paginator is a Flutter package that provides a customizable pagination widget for your Flutter applications.

Features
Customizable pagination widget with configurable buttons and text.
Supports both vertical and horizontal pagination.
Provides callback functions for handling pagination events.
Installation
To use X Paginator in your Flutter project, add the following dependency to your pubspec.yaml file:

yaml

dependencies:
  x_paginator: ^1.0.0
Then, run flutter pub get to install the package.

Usage
To use X Paginator in your Flutter project, import the package:

dart

import 'package:x_paginator/x_paginator.dart';
Then, add the XPaginator widget to your widget tree:

dart

XPaginator(
  itemCount: 100,
  onPageChanged: (int pageIndex) {
    // Handle pagination events
  },
)
You can customize the appearance of the XPaginator widget using the various constructor parameters. For example:

dart

XPaginator(
  itemCount: 100,
  buttonColor: Colors.blue,
  activeTextColor: Colors.white,
  onPageChanged: (int pageIndex) {
    // Handle pagination events
  },
)
For a full list of available customization options, refer to the XPaginator documentation.

Examples
For example usage of X Paginator, refer to the example directory in the repository.

Contributing
If you'd like to contribute to X Paginator, please fork the repository and create a new branch for your changes. Once you've made your changes, submit a pull request and we'll review your changes.

License
This package is licensed under the MIT License. See the LICENSE file for details.

Acknowledgements
X Paginator was inspired by the Flutter Pagination package.