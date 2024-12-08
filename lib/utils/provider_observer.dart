import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/constants/app_constants.dart';

class AppObserver extends ProviderObserver {
  @override
  void didAddProvider(
      ProviderBase<Object?> provider,
      Object? value,
      ProviderContainer container,
      ) {
    debugPrint(
        '${AppConstants.tag} Provider ${provider.name} was initialized with $value');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider,
      ProviderContainer container,
      ) {
    debugPrint('${AppConstants.tag} Provider ${provider.name} was disposed');
  }

  @override
  void didUpdateProvider(
      ProviderBase<Object?> provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    debugPrint(
        '${AppConstants.tag} Provider ${provider.name} updated from $previousValue to $newValue');
  }

  @override
  void providerDidFail(
      ProviderBase<Object?> provider,
      Object error,
      StackTrace stackTrace,
      ProviderContainer container,
      ) {
    debugPrint(
        '${AppConstants.tag} Provider ${provider.name} threw $error at $stackTrace');
  }
}
