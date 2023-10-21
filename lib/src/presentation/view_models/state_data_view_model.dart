import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../domain/domain.dart';

class StateDataVM<T> extends Equatable {
  const StateDataVM(this.data, this.errorMessage, {this.state = LoadingState.initial});

  final LoadingState state;
  final T? data;
  final String? errorMessage;

  static none<E>(Type type) {
    switch (type) {
      case List:
        final List<E> list = [];
        return StateDataVM(list, null);
      case RxList:
        final RxList<E> list = RxList<E>.empty();
        return StateDataVM(list, null);
      default:
        return const StateDataVM(null, null);
    }
  }

  StateDataVM<T> _copyWith({
    LoadingState? state,
    T? data,
    required String? errorMessage,
  }) {
    return StateDataVM<T>(
      data ?? this.data,
      errorMessage,
      state: state ?? this.state,
    );
  }

  StateDataVM<T> setLoading() {
    return _copyWith(errorMessage: null, state: LoadingState.loading);
  }

  StateDataVM<T> setSuccess(T data) {
    return _copyWith(data: data, errorMessage: null, state: LoadingState.success);
  }

  StateDataVM<T> setError(String errorMessage) {
    return _copyWith(errorMessage: errorMessage, state: LoadingState.error);
  }

  StateDataVM<T> setEmpty() {
    return _copyWith(errorMessage: null, state: LoadingState.empty);
  }

  get isInitial => state.isInitial;

  get isLoading => state.isLoading;

  get isSuccess => state.isSuccess;

  get isError => state.isError;

  get isEmpty => state.isEmpty;

  @override
  List<Object?> get props => [state, data, errorMessage];
}
