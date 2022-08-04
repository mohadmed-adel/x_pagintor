import 'package:flutter/material.dart';

typedef PageLoadFuture<T> = Future<T> Function(int page);
typedef PageItemsGetter<T> = List<dynamic> Function(T pageData);
typedef ListItemBuilder = Widget Function(dynamic itemData, int index);
typedef LoadingWidgetBuilder = Widget Function();
typedef RetryListener = void Function();
typedef ErrorWidgetBuilder<T> = Widget Function(
    T pageData, RetryListener retryListener);
typedef EmptyListWidgetBuilder<T> = Widget Function(T pageData);
typedef TotalItemsGetter<T> = int Function(T pageData);
typedef PageItemCounter<T> = int Function(T pageData);
typedef PageErrorChecker<T> = bool Function(T pageData);
