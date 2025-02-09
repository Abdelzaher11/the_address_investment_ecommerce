// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_bloc/flutter_bloc.dart';

extension SafeEmit<T> on BlocBase<T> {
  /// Safely emits a new state to the Bloc only if the Bloc is not closed.
  ///
  /// This method is useful when you want to emit a new state from outside the Bloc,
  /// but you're not sure if the Bloc is still open.
  ///
  /// If the Bloc is not closed, the [state] will be emitted to the Bloc.
  /// If the Bloc is closed, the [state] will be ignored.
  ///
  /// This method is useful in scenarios where you want to emit a new state to the
  /// Bloc from outside the Bloc, but you're not sure if the Bloc is still open.
  /// For example, you might want to emit a new state to the Bloc from a callback
  /// that is called after the Bloc is closed.
  ///
  /// This method is safe to call from any isolate.
  void safeEmit(T state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
