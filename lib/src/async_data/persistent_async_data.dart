abstract class PersistentAsyncData<E extends Object?, D extends Object?> {
  final D data;

  const PersistentAsyncData._(this.data);

  const factory PersistentAsyncData.loading({
    required D data,
  }) = PersistentAsyncDataLoading;

  const factory PersistentAsyncData.idle({
    required D data,
  }) = PersistentAsyncDataIdle;

  const factory PersistentAsyncData.error({
    required D data,
    required E error,
  }) = PersistentAsyncDataError;

  E? get error;

  bool get isLoading;

  bool get isIdle;

  bool get isError;

  PersistentAsyncData<E, B> map<B>(
    B Function(D data) mapper,
  );

  PersistentAsyncData<A, D> mapError<A>(
    A Function(E error) mapper,
  );

  R match<R>({
    required R Function(PersistentAsyncDataLoading<E, D> loading) loading,
    required R Function(PersistentAsyncDataIdle<E, D> idle) idle,
    required R Function(PersistentAsyncDataError<E, D> error) error,
  });

  R matchOr<R>({
    R Function(PersistentAsyncDataLoading<E, D> loading)? loading,
    R Function(PersistentAsyncDataIdle<E, D> idle)? idle,
    R Function(PersistentAsyncDataError<E, D> error)? error,
    required R Function() fallback,
  });

  R? matchOrNull<R>({
    R Function(PersistentAsyncDataLoading<E, D> loading)? loading,
    R Function(PersistentAsyncDataIdle<E, D> idle)? idle,
    R Function(PersistentAsyncDataError<E, D> error)? error,
  });

  R when<R>({
    required R Function(D data) loading,
    required R Function(D data) idle,
    required R Function(E error, D data) error,
  });

  R whenOr<R>({
    R Function(D data)? loading,
    R Function(D data)? idle,
    R Function(E error, D data)? error,
    required R Function() fallback,
  });

  R? whenOrNull<R>({
    R Function(D data)? loading,
    R Function(D data)? idle,
    R Function(E error, D data)? error,
  });
}

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
  PersistentAsyncData<E, B> map<B>(
    B Function(D data) mapper,
  ) =>
      PersistentAsyncData.loading(data: mapper(data));

  @override
  PersistentAsyncData<A, D> mapError<A>(
    A Function(E error) mapper,
  ) =>
      PersistentAsyncData.loading(data: data);

  @override
  R match<R>({
    required R Function(PersistentAsyncDataLoading<E, D> loading) loading,
    required R Function(PersistentAsyncDataIdle<E, D> idle) idle,
    required R Function(PersistentAsyncDataError<E, D> error) error,
  }) =>
      loading(this);

  @override
  R matchOr<R>({
    R Function(PersistentAsyncDataLoading<E, D> loading)? loading,
    R Function(PersistentAsyncDataIdle<E, D> idle)? idle,
    R Function(PersistentAsyncDataError<E, D> error)? error,
    required R Function() fallback,
  }) =>
      loading?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(PersistentAsyncDataLoading<E, D> loading)? loading,
    R Function(PersistentAsyncDataIdle<E, D> idle)? idle,
    R Function(PersistentAsyncDataError<E, D> error)? error,
  }) =>
      loading?.call(this);

  @override
  R when<R>({
    required R Function(D data) loading,
    required R Function(D data) idle,
    required R Function(E error, D data) error,
  }) =>
      loading(data);

  @override
  R whenOr<R>({
    R Function(D data)? loading,
    R Function(D data)? idle,
    R Function(E error, D data)? error,
    required R Function() fallback,
  }) =>
      loading?.call(data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function(D data)? loading,
    R Function(D data)? idle,
    R Function(E error, D data)? error,
  }) =>
      loading?.call(data);

  @override
  String toString() => 'PersistentAsyncData.loading(data: $data)';

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is PersistentAsyncDataLoading &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

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
  PersistentAsyncData<E, B> map<B>(
    B Function(D data) mapper,
  ) =>
      PersistentAsyncData.idle(data: mapper(data));

  @override
  PersistentAsyncData<A, D> mapError<A>(
    A Function(E error) mapper,
  ) =>
      PersistentAsyncData.idle(data: data);

  @override
  R match<R>({
    required R Function(PersistentAsyncDataLoading<E, D> loading) loading,
    required R Function(PersistentAsyncDataIdle<E, D> idle) idle,
    required R Function(PersistentAsyncDataError<E, D> error) error,
  }) =>
      idle(this);

  @override
  R matchOr<R>({
    R Function(PersistentAsyncDataLoading<E, D> loading)? loading,
    R Function(PersistentAsyncDataIdle<E, D> idle)? idle,
    R Function(PersistentAsyncDataError<E, D> error)? error,
    required R Function() fallback,
  }) =>
      idle?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(PersistentAsyncDataLoading<E, D> loading)? loading,
    R Function(PersistentAsyncDataIdle<E, D> idle)? idle,
    R Function(PersistentAsyncDataError<E, D> error)? error,
  }) =>
      idle?.call(this);

  @override
  R when<R>({
    required R Function(D data) loading,
    required R Function(D data) idle,
    required R Function(E error, D data) error,
  }) =>
      idle(data);

  @override
  R whenOr<R>({
    R Function(D data)? loading,
    R Function(D data)? idle,
    R Function(E error, D data)? error,
    required R Function() fallback,
  }) =>
      idle?.call(data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function(D data)? loading,
    R Function(D data)? idle,
    R Function(E error, D data)? error,
  }) =>
      idle?.call(data);

  @override
  String toString() => 'PersistentAsyncData.idle(data: $data)';

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is PersistentAsyncDataIdle &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

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
  PersistentAsyncData<E, B> map<B>(
    B Function(D data) mapper,
  ) =>
      PersistentAsyncData.error(data: mapper(data), error: error);

  @override
  PersistentAsyncData<A, D> mapError<A>(
    A Function(E error) mapper,
  ) =>
      PersistentAsyncData.error(data: data, error: mapper(error));

  @override
  R match<R>({
    required R Function(PersistentAsyncDataLoading<E, D> loading) loading,
    required R Function(PersistentAsyncDataIdle<E, D> idle) idle,
    required R Function(PersistentAsyncDataError<E, D> error) error,
  }) =>
      error(this);

  @override
  R matchOr<R>({
    R Function(PersistentAsyncDataLoading<E, D> loading)? loading,
    R Function(PersistentAsyncDataIdle<E, D> idle)? idle,
    R Function(PersistentAsyncDataError<E, D> error)? error,
    required R Function() fallback,
  }) =>
      error?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(PersistentAsyncDataLoading<E, D> loading)? loading,
    R Function(PersistentAsyncDataIdle<E, D> idle)? idle,
    R Function(PersistentAsyncDataError<E, D> error)? error,
  }) =>
      error?.call(this);

  @override
  R when<R>({
    required R Function(D data) loading,
    required R Function(D data) idle,
    required R Function(E error, D data) error,
  }) =>
      error(this.error, data);

  @override
  R whenOr<R>({
    R Function(D data)? loading,
    R Function(D data)? idle,
    R Function(E error, D data)? error,
    required R Function() fallback,
  }) =>
      error?.call(this.error, data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function(D data)? loading,
    R Function(D data)? idle,
    R Function(E error, D data)? error,
  }) =>
      error?.call(this.error, data);

  @override
  String toString() => 'PersistentAsyncData.error(data: $data, error: $error)';

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is PersistentAsyncDataError &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          error == other.error;

  @override
  int get hashCode => data.hashCode ^ error.hashCode;
}
