import 'package:meta/meta.dart';

// --- Abstract --- //

/// A sum type for asynchronous data that is obtained as a result of an
/// operation.
///
/// Has four variations – `initial`, `loading`, `success` and `error`.
/// `success` stores [data], while `error` stores [error] and `initial` and
/// `loading` are empty.
///
/// An example of usage would be a result of an HTTP request through its
/// stages.
@immutable
@sealed
abstract class OperationAsyncData<E extends Object?, D extends Object?> {
  const OperationAsyncData._();

  @literal
  const factory OperationAsyncData.initial() = OperationAsyncDataInitial;

  @literal
  const factory OperationAsyncData.loading() = OperationAsyncDataLoading;

  const factory OperationAsyncData.success({
    required D data,
  }) = OperationAsyncDataSuccess;

  const factory OperationAsyncData.error({
    required E error,
  }) = OperationAsyncDataError;

  static Stream<OperationAsyncData<E, D>>
      fromOperation<E extends Object?, D extends Object?>({
    required Future<D> Function() body,
    required E Function(Object error, StackTrace stackTrace) onError,
    bool shouldRethrow = false,
  }) async* {
    yield const OperationAsyncData.loading();

    try {
      final data = await body();

      yield OperationAsyncData.success(data: data);
    } on Object catch (e, s) {
      final error = onError(e, s);

      yield OperationAsyncData.error(error: error);

      if (shouldRethrow) rethrow;
    }
  }

  D? get data;

  E? get error;

  bool get isInitial;

  bool get isLoading;

  bool get isSuccess;

  bool get isError;

  bool get hasData => data != null;

  bool get hasError => error != null;

  OperationAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  );

  OperationAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  );

  OperationAsyncData<E, B> flatMap<B extends Object?>(
    OperationAsyncData<E, B> Function(D data) mapper,
  );

  R match<R>({
    required R Function(OperationAsyncDataInitial data) initial,
    required R Function(OperationAsyncDataLoading data) loading,
    required R Function(OperationAsyncDataSuccess<E, D> data) success,
    required R Function(OperationAsyncDataError<E, D> data) error,
  });

  R matchOr<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  });

  R? matchOrNull<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
  });

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(D data) success,
    required R Function(E error) error,
  });

  R whenOr<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
    required R Function() fallback,
  });

  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
  });
}

// --- Initial --- //

@immutable
@sealed
class OperationAsyncDataInitial<E extends Object?, D extends Object?>
    extends OperationAsyncData<E, D> {
  @literal
  const OperationAsyncDataInitial() : super._();

  @override
  D? get data => null;

  @override
  E? get error => null;

  @override
  bool get isInitial => true;

  @override
  bool get isLoading => false;

  @override
  bool get isSuccess => false;

  @override
  bool get isError => false;

  @override
  OperationAsyncData<E, B> map<B>(
    B Function(D data) mapper,
  ) =>
      const OperationAsyncData.initial();

  @override
  OperationAsyncData<A, D> mapError<A>(
    A Function(E error) mapper,
  ) =>
      const OperationAsyncData.initial();

  @override
  OperationAsyncData<E, B> flatMap<B>(
    OperationAsyncData<E, B> Function(D data) mapper,
  ) =>
      const OperationAsyncData.initial();

  @override
  R match<R>({
    required R Function(OperationAsyncDataInitial data) initial,
    required R Function(OperationAsyncDataLoading data) loading,
    required R Function(OperationAsyncDataSuccess<E, D> data) success,
    required R Function(OperationAsyncDataError<E, D> data) error,
  }) =>
      initial(this);

  @override
  R matchOr<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  }) =>
      initial?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
  }) =>
      initial?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(D data) success,
    required R Function(E error) error,
  }) =>
      initial();

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
    required R Function() fallback,
  }) =>
      initial?.call() ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
  }) =>
      initial?.call();

  @override
  String toString() => 'OperationAsyncData.initial()';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || other is OperationAsyncDataInitial<E, D>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// --- Loading --- //

@immutable
@sealed
class OperationAsyncDataLoading<E extends Object?, D extends Object?>
    extends OperationAsyncData<E, D> {
  @literal
  const OperationAsyncDataLoading() : super._();

  @override
  D? get data => null;

  @override
  E? get error => null;

  @override
  bool get isInitial => false;

  @override
  bool get isLoading => true;

  @override
  bool get isSuccess => false;

  @override
  bool get isError => false;

  @override
  OperationAsyncData<E, B> map<B>(
    B Function(D data) mapper,
  ) =>
      const OperationAsyncData.loading();

  @override
  OperationAsyncData<A, D> mapError<A>(
    A Function(E error) mapper,
  ) =>
      const OperationAsyncData.loading();

  @override
  OperationAsyncData<E, B> flatMap<B>(
    OperationAsyncData<E, B> Function(D data) mapper,
  ) =>
      const OperationAsyncData.loading();

  @override
  R match<R>({
    required R Function(OperationAsyncDataInitial data) initial,
    required R Function(OperationAsyncDataLoading data) loading,
    required R Function(OperationAsyncDataSuccess<E, D> data) success,
    required R Function(OperationAsyncDataError<E, D> data) error,
  }) =>
      loading(this);

  @override
  R matchOr<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  }) =>
      loading?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
  }) =>
      loading?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(D data) success,
    required R Function(E error) error,
  }) =>
      loading();

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
    required R Function() fallback,
  }) =>
      loading?.call() ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
  }) =>
      loading?.call();

  @override
  String toString() => 'OperationAsyncData.loading()';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || other is OperationAsyncDataLoading<E, D>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// --- Success --- //

@immutable
@sealed
class OperationAsyncDataSuccess<E extends Object?, D extends Object?>
    extends OperationAsyncData<E, D> {
  @override
  final D data;

  const OperationAsyncDataSuccess({
    required this.data,
  }) : super._();

  @override
  E? get error => null;

  @override
  bool get isInitial => false;

  @override
  bool get isLoading => false;

  @override
  bool get isSuccess => true;

  @override
  bool get isError => false;

  @override
  OperationAsyncData<E, B> map<B>(
    B Function(D data) mapper,
  ) =>
      OperationAsyncData.success(data: mapper(data));

  @override
  OperationAsyncData<A, D> mapError<A>(
    A Function(E error) mapper,
  ) =>
      OperationAsyncData.success(data: data);

  @override
  OperationAsyncData<E, B> flatMap<B>(
    OperationAsyncData<E, B> Function(D data) mapper,
  ) =>
      mapper(data);

  @override
  R match<R>({
    required R Function(OperationAsyncDataInitial data) initial,
    required R Function(OperationAsyncDataLoading data) loading,
    required R Function(OperationAsyncDataSuccess<E, D> data) success,
    required R Function(OperationAsyncDataError<E, D> data) error,
  }) =>
      success(this);

  @override
  R matchOr<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  }) =>
      success?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
  }) =>
      success?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(D data) success,
    required R Function(E error) error,
  }) =>
      success(data);

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
    required R Function() fallback,
  }) =>
      success?.call(data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
  }) =>
      success?.call(data);

  @override
  String toString() => 'OperationAsyncData.success(data: $data)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is OperationAsyncDataSuccess<E, D> && data == other.data);

  @override
  int get hashCode => data.hashCode;
}

// --- Error --- //

@immutable
@sealed
class OperationAsyncDataError<E extends Object?, D extends Object?>
    extends OperationAsyncData<E, D> {
  @override
  final E error;

  const OperationAsyncDataError({
    required this.error,
  }) : super._();

  @override
  D? get data => null;

  @override
  bool get isInitial => false;

  @override
  bool get isLoading => false;

  @override
  bool get isSuccess => false;

  @override
  bool get isError => true;

  @override
  OperationAsyncData<E, B> map<B>(
    B Function(D data) mapper,
  ) =>
      OperationAsyncData.error(error: error);

  @override
  OperationAsyncData<A, D> mapError<A>(
    A Function(E error) mapper,
  ) =>
      OperationAsyncData.error(error: mapper(error));

  @override
  OperationAsyncData<E, B> flatMap<B>(
    OperationAsyncData<E, B> Function(D data) mapper,
  ) =>
      OperationAsyncData.error(error: error);

  @override
  R match<R>({
    required R Function(OperationAsyncDataInitial data) initial,
    required R Function(OperationAsyncDataLoading data) loading,
    required R Function(OperationAsyncDataSuccess<E, D> data) success,
    required R Function(OperationAsyncDataError<E, D> data) error,
  }) =>
      error(this);

  @override
  R matchOr<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  }) =>
      error?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(OperationAsyncDataInitial data)? initial,
    R Function(OperationAsyncDataLoading data)? loading,
    R Function(OperationAsyncDataSuccess<E, D> data)? success,
    R Function(OperationAsyncDataError<E, D> data)? error,
  }) =>
      error?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(D data) success,
    required R Function(E error) error,
  }) =>
      error(this.error);

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
    required R Function() fallback,
  }) =>
      error?.call(this.error) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(D data)? success,
    R Function(E error)? error,
  }) =>
      error?.call(this.error);

  @override
  String toString() => 'OperationAsyncData.error(error: $error)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is OperationAsyncDataError<E, D> && error == other.error);

  @override
  int get hashCode => error.hashCode;
}
