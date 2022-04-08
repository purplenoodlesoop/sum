// --- Abstract --- //

import 'package:meta/meta.dart';

/// A sum type for asynchronous data that is present in every of its states.
///
/// Has three variations – `loading`, `idle` and `error`. Every state has a
/// [data] getter that returns the data, and `error` additionally has a [error]
/// getter.
///
/// An example of usage would be a state of apps settings – they are present
/// from the start and throughout the app and can be loaded, idle or error.
@immutable
@sealed
abstract class PersistentAsyncData<E extends Object?, D extends Object?> {
  final D data;

  const PersistentAsyncData._(this.data);

  const factory PersistentAsyncData.idle({
    required D data,
  }) = PersistentAsyncDataIdle;

  const factory PersistentAsyncData.loading({
    required D data,
  }) = PersistentAsyncDataLoading;

  const factory PersistentAsyncData.error({
    required D data,
    required E error,
  }) = PersistentAsyncDataError;

  E? get error;

  bool get isLoading;

  bool get isIdle;

  bool get isError;

  PersistentAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  );

  PersistentAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  );

  R match<R>({
    required R Function(PersistentAsyncDataIdle<E, D> data) idle,
    required R Function(PersistentAsyncDataLoading<E, D> data) loading,
    required R Function(PersistentAsyncDataError<E, D> data) error,
  });

  R matchOr<R>({
    R Function(PersistentAsyncDataIdle<E, D> data)? idle,
    R Function(PersistentAsyncDataLoading<E, D> data)? loading,
    R Function(PersistentAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  });

  R? matchOrNull<R>({
    R Function(PersistentAsyncDataIdle<E, D> data)? idle,
    R Function(PersistentAsyncDataLoading<E, D> data)? loading,
    R Function(PersistentAsyncDataError<E, D> data)? error,
  });

  R when<R>({
    required R Function(D data) idle,
    required R Function(D data) loading,
    required R Function(E error, D data) error,
  });

  R whenOr<R>({
    R Function(D data)? idle,
    R Function(D data)? loading,
    R Function(E error, D data)? error,
    required R Function() fallback,
  });

  R? whenOrNull<R>({
    R Function(D data)? idle,
    R Function(D data)? loading,
    R Function(E error, D data)? error,
  });
}

// --- Idle --- //

@immutable
@sealed
class PersistentAsyncDataIdle<E extends Object?, D extends Object?>
    extends PersistentAsyncData<E, D> {
  const PersistentAsyncDataIdle({
    required D data,
  }) : super._(data);

  @override
  E? get error => null;

  @override
  bool get isLoading => false;

  @override
  bool get isIdle => true;

  @override
  bool get isError => false;

  @override
  PersistentAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      PersistentAsyncData.idle(data: mapper(data));

  @override
  PersistentAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      PersistentAsyncData.idle(data: data);

  @override
  R match<R>({
    required R Function(PersistentAsyncDataIdle<E, D> data) idle,
    required R Function(PersistentAsyncDataLoading<E, D> data) loading,
    required R Function(PersistentAsyncDataError<E, D> data) error,
  }) =>
      idle(this);

  @override
  R matchOr<R>({
    R Function(PersistentAsyncDataIdle<E, D> data)? idle,
    R Function(PersistentAsyncDataLoading<E, D> data)? loading,
    R Function(PersistentAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  }) =>
      idle?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(PersistentAsyncDataIdle<E, D> data)? idle,
    R Function(PersistentAsyncDataLoading<E, D> data)? loading,
    R Function(PersistentAsyncDataError<E, D> data)? error,
  }) =>
      idle?.call(this);

  @override
  R when<R>({
    required R Function(D data) idle,
    required R Function(D data) loading,
    required R Function(E error, D data) error,
  }) =>
      idle(data);

  @override
  R whenOr<R>({
    R Function(D data)? idle,
    R Function(D data)? loading,
    R Function(E error, D data)? error,
    required R Function() fallback,
  }) =>
      idle?.call(data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function(D data)? idle,
    R Function(D data)? loading,
    R Function(E error, D data)? error,
  }) =>
      idle?.call(data);

  @override
  String toString() => 'PersistentAsyncData.idle(data: $data)';

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is PersistentAsyncDataIdle && data == other.data;

  @override
  int get hashCode => data.hashCode;
}

// --- Loading --- //

@immutable
@sealed
class PersistentAsyncDataLoading<E extends Object?, D extends Object?>
    extends PersistentAsyncData<E, D> {
  const PersistentAsyncDataLoading({
    required D data,
  }) : super._(data);

  @override
  E? get error => null;

  @override
  bool get isLoading => true;

  @override
  bool get isIdle => false;

  @override
  bool get isError => false;

  @override
  PersistentAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      PersistentAsyncData.loading(data: mapper(data));

  @override
  PersistentAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      PersistentAsyncData.loading(data: data);

  @override
  R match<R>({
    required R Function(PersistentAsyncDataIdle<E, D> data) idle,
    required R Function(PersistentAsyncDataLoading<E, D> data) loading,
    required R Function(PersistentAsyncDataError<E, D> data) error,
  }) =>
      loading(this);

  @override
  R matchOr<R>({
    R Function(PersistentAsyncDataIdle<E, D> data)? idle,
    R Function(PersistentAsyncDataLoading<E, D> data)? loading,
    R Function(PersistentAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  }) =>
      loading?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(PersistentAsyncDataIdle<E, D> data)? idle,
    R Function(PersistentAsyncDataLoading<E, D> data)? loading,
    R Function(PersistentAsyncDataError<E, D> data)? error,
  }) =>
      loading?.call(this);

  @override
  R when<R>({
    required R Function(D data) idle,
    required R Function(D data) loading,
    required R Function(E error, D data) error,
  }) =>
      loading(data);

  @override
  R whenOr<R>({
    R Function(D data)? idle,
    R Function(D data)? loading,
    R Function(E error, D data)? error,
    required R Function() fallback,
  }) =>
      loading?.call(data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function(D data)? idle,
    R Function(D data)? loading,
    R Function(E error, D data)? error,
  }) =>
      loading?.call(data);

  @override
  String toString() => 'PersistentAsyncData.loading(data: $data)';

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is PersistentAsyncDataLoading && data == other.data;

  @override
  int get hashCode => data.hashCode;
}

// --- Error --- //

@immutable
@sealed
class PersistentAsyncDataError<E extends Object?, D extends Object?>
    extends PersistentAsyncData<E, D> {
  @override
  final E error;

  const PersistentAsyncDataError({
    required D data,
    required this.error,
  }) : super._(data);

  @override
  bool get isLoading => false;

  @override
  bool get isIdle => false;

  @override
  bool get isError => true;

  @override
  PersistentAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      PersistentAsyncData.error(data: mapper(data), error: error);

  @override
  PersistentAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      PersistentAsyncData.error(data: data, error: mapper(error));

  @override
  R match<R>({
    required R Function(PersistentAsyncDataIdle<E, D> data) idle,
    required R Function(PersistentAsyncDataLoading<E, D> data) loading,
    required R Function(PersistentAsyncDataError<E, D> data) error,
  }) =>
      error(this);

  @override
  R matchOr<R>({
    R Function(PersistentAsyncDataIdle<E, D> data)? idle,
    R Function(PersistentAsyncDataLoading<E, D> data)? loading,
    R Function(PersistentAsyncDataError<E, D> data)? error,
    required R Function() fallback,
  }) =>
      error?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(PersistentAsyncDataIdle<E, D> data)? idle,
    R Function(PersistentAsyncDataLoading<E, D> data)? loading,
    R Function(PersistentAsyncDataError<E, D> data)? error,
  }) =>
      error?.call(this);

  @override
  R when<R>({
    required R Function(D data) idle,
    required R Function(D data) loading,
    required R Function(E error, D data) error,
  }) =>
      error(this.error, data);

  @override
  R whenOr<R>({
    R Function(D data)? idle,
    R Function(D data)? loading,
    R Function(E error, D data)? error,
    required R Function() fallback,
  }) =>
      error?.call(this.error, data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function(D data)? idle,
    R Function(D data)? loading,
    R Function(E error, D data)? error,
  }) =>
      error?.call(this.error, data);

  @override
  String toString() => 'PersistentAsyncData.error(data: $data, error: $error)';

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is PersistentAsyncDataError &&
          data == other.data &&
          error == other.error;

  @override
  int get hashCode => data.hashCode ^ error.hashCode;
}
