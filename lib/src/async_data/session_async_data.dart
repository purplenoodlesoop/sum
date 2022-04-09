import 'package:meta/meta.dart';

// --- Abstract --- //

/// A sum type for asynchronous data that is obtained through some kind of
/// ongoing session.
///
/// Has six different variations – `initial`, `connecting`, `idle`, `updating`,
/// `error` and `fatalError`. `idle`, `updating` and `error` has [data], while
/// `error` and `fatalError` additionally has [error].
///
/// An example of usage would be a communications stages with a local database
/// or a WebSocket.
@immutable
@sealed
abstract class SessionAsyncData<E extends Object?, D extends Object?> {
  const SessionAsyncData._();

  @literal
  const factory SessionAsyncData.initial() = SessionAsyncDataInitial;

  @literal
  const factory SessionAsyncData.connecting() = SessionAsyncDataConnecting;

  const factory SessionAsyncData.idle({
    required D data,
  }) = SessionAsyncDataIdle;

  const factory SessionAsyncData.updating({
    required D data,
  }) = SessionAsyncDataUpdating;

  const factory SessionAsyncData.error({
    required D data,
    required E error,
  }) = SessionAsyncDataError;

  const factory SessionAsyncData.fatalError({
    required E error,
  }) = SessionAsyncDataFatalError;

  D? get data;

  E? get error;

  bool get isInitial;

  bool get isConnecting;

  bool get isIdle;

  bool get isUpdating;

  bool get isError;

  bool get isFatalError;

  bool get isLoading => isConnecting || isUpdating;

  bool get hasData => data != null;

  bool get hasError => error != null;

  SessionAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  );

  SessionAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  );

  SessionAsyncData<E, B> flatMap<B extends Object?>(
    SessionAsyncData<E, B> Function(D data) mapper,
  );

  R match<R>({
    required R Function(SessionAsyncDataInitial data) initial,
    required R Function(SessionAsyncDataConnecting data) connecting,
    required R Function(SessionAsyncDataIdle<E, D> data) idle,
    required R Function(SessionAsyncDataUpdating<E, D> data) updating,
    required R Function(SessionAsyncDataError<E, D> data) error,
    required R Function(SessionAsyncDataFatalError<E, D> data) fatalError,
  });

  R matchOr<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
    required R Function() fallback,
  });

  R? matchOrNull<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
  });

  R when<R>({
    required R Function() initial,
    required R Function() connecting,
    required R Function(D data) idle,
    required R Function(D data) updating,
    required R Function(E error, D data) error,
    required R Function(E error) fatalError,
  });

  R whenOr<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
    required R Function() fallback,
  });

  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
  });
}

// --- Initial --- //

@immutable
@sealed
class SessionAsyncDataInitial<E extends Object?, D extends Object?>
    extends SessionAsyncData<E, D> {
  @literal
  const SessionAsyncDataInitial() : super._();

  @override
  D? get data => null;

  @override
  E? get error => null;

  @override
  bool get isInitial => true;

  @override
  bool get isConnecting => false;

  @override
  bool get isIdle => false;

  @override
  bool get isUpdating => false;

  @override
  bool get isError => false;

  @override
  bool get isFatalError => false;

  @override
  SessionAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      const SessionAsyncData.initial();

  @override
  SessionAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      const SessionAsyncData.initial();

  @override
  SessionAsyncData<E, B> flatMap<B extends Object?>(
    SessionAsyncData<E, B> Function(D data) mapper,
  ) =>
      const SessionAsyncData.initial();

  @override
  R match<R>({
    required R Function(SessionAsyncDataInitial data) initial,
    required R Function(SessionAsyncDataConnecting data) connecting,
    required R Function(SessionAsyncDataIdle<E, D> data) idle,
    required R Function(SessionAsyncDataUpdating<E, D> data) updating,
    required R Function(SessionAsyncDataError<E, D> data) error,
    required R Function(SessionAsyncDataFatalError<E, D> data) fatalError,
  }) =>
      initial(this);

  @override
  R matchOr<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
    required R Function() fallback,
  }) =>
      initial?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
  }) =>
      initial?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() connecting,
    required R Function(D data) idle,
    required R Function(D data) updating,
    required R Function(E error, D data) error,
    required R Function(E error) fatalError,
  }) =>
      initial();

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
    required R Function() fallback,
  }) =>
      initial?.call() ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
  }) =>
      initial?.call();

  @override
  String toString() => 'SessionAsyncData.initial()';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || other is SessionAsyncDataInitial<E, D>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// --- Connecting --- //

@immutable
@sealed
class SessionAsyncDataConnecting<E extends Object?, D extends Object?>
    extends SessionAsyncData<E, D> {
  @literal
  const SessionAsyncDataConnecting() : super._();

  @override
  D? get data => null;

  @override
  E? get error => null;

  @override
  bool get isInitial => false;

  @override
  bool get isConnecting => true;

  @override
  bool get isIdle => false;

  @override
  bool get isUpdating => false;

  @override
  bool get isError => false;

  @override
  bool get isFatalError => false;

  @override
  SessionAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      const SessionAsyncData.connecting();

  @override
  SessionAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      const SessionAsyncData.connecting();

  @override
  SessionAsyncData<E, B> flatMap<B extends Object?>(
    SessionAsyncData<E, B> Function(D data) mapper,
  ) =>
      const SessionAsyncData.connecting();

  @override
  R match<R>({
    required R Function(SessionAsyncDataInitial data) initial,
    required R Function(SessionAsyncDataConnecting data) connecting,
    required R Function(SessionAsyncDataIdle<E, D> data) idle,
    required R Function(SessionAsyncDataUpdating<E, D> data) updating,
    required R Function(SessionAsyncDataError<E, D> data) error,
    required R Function(SessionAsyncDataFatalError<E, D> data) fatalError,
  }) =>
      connecting(this);

  @override
  R matchOr<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
    required R Function() fallback,
  }) =>
      connecting?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
  }) =>
      connecting?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() connecting,
    required R Function(D data) idle,
    required R Function(D data) updating,
    required R Function(E error, D data) error,
    required R Function(E error) fatalError,
  }) =>
      connecting();

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
    required R Function() fallback,
  }) =>
      connecting?.call() ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
  }) =>
      connecting?.call();

  @override
  String toString() => 'SessionAsyncData.connecting()';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || other is SessionAsyncDataConnecting<E, D>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// --- Idle --- //

@immutable
@sealed
class SessionAsyncDataIdle<E extends Object?, D extends Object?>
    extends SessionAsyncData<E, D> {
  @override
  final D data;

  const SessionAsyncDataIdle({required this.data}) : super._();

  @override
  E? get error => null;

  @override
  bool get isInitial => false;

  @override
  bool get isConnecting => false;

  @override
  bool get isIdle => true;

  @override
  bool get isUpdating => false;

  @override
  bool get isError => false;

  @override
  bool get isFatalError => false;

  @override
  SessionAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      SessionAsyncDataIdle(data: mapper(data));

  @override
  SessionAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      SessionAsyncDataIdle(data: data);

  @override
  SessionAsyncData<E, B> flatMap<B extends Object?>(
    SessionAsyncData<E, B> Function(D data) mapper,
  ) =>
      mapper(data);

  @override
  R match<R>({
    required R Function(SessionAsyncDataInitial data) initial,
    required R Function(SessionAsyncDataConnecting data) connecting,
    required R Function(SessionAsyncDataIdle<E, D> data) idle,
    required R Function(SessionAsyncDataUpdating<E, D> data) updating,
    required R Function(SessionAsyncDataError<E, D> data) error,
    required R Function(SessionAsyncDataFatalError<E, D> data) fatalError,
  }) =>
      idle(this);

  @override
  R matchOr<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
    required R Function() fallback,
  }) =>
      idle?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
  }) =>
      idle?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() connecting,
    required R Function(D data) idle,
    required R Function(D data) updating,
    required R Function(E error, D data) error,
    required R Function(E error) fatalError,
  }) =>
      idle(data);

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
    required R Function() fallback,
  }) =>
      idle?.call(data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
  }) =>
      idle?.call(data);

  @override
  String toString() => 'SessionAsyncData.idle(data: $data)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SessionAsyncDataIdle<E, D> && data == other.data);

  @override
  int get hashCode => data.hashCode;
}

// --- Updating --- //

@immutable
@sealed
class SessionAsyncDataUpdating<E extends Object?, D extends Object?>
    extends SessionAsyncData<E, D> {
  @override
  final D data;

  const SessionAsyncDataUpdating({required this.data}) : super._();

  @override
  E? get error => null;

  @override
  bool get isInitial => false;

  @override
  bool get isConnecting => false;

  @override
  bool get isIdle => false;

  @override
  bool get isUpdating => true;

  @override
  bool get isError => false;

  @override
  bool get isFatalError => false;

  @override
  SessionAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      SessionAsyncDataUpdating(data: mapper(data));

  @override
  SessionAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      SessionAsyncDataUpdating(data: data);

  @override
  SessionAsyncData<E, B> flatMap<B extends Object?>(
    SessionAsyncData<E, B> Function(D data) mapper,
  ) =>
      mapper(data);

  @override
  R match<R>({
    required R Function(SessionAsyncDataInitial data) initial,
    required R Function(SessionAsyncDataConnecting data) connecting,
    required R Function(SessionAsyncDataIdle<E, D> data) idle,
    required R Function(SessionAsyncDataUpdating<E, D> data) updating,
    required R Function(SessionAsyncDataError<E, D> data) error,
    required R Function(SessionAsyncDataFatalError<E, D> data) fatalError,
  }) =>
      updating(this);

  @override
  R matchOr<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
    required R Function() fallback,
  }) =>
      updating?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
  }) =>
      updating?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() connecting,
    required R Function(D data) idle,
    required R Function(D data) updating,
    required R Function(E error, D data) error,
    required R Function(E error) fatalError,
  }) =>
      updating(data);

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
    required R Function() fallback,
  }) =>
      updating?.call(data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
  }) =>
      updating?.call(data);

  @override
  String toString() => 'SessionAsyncData.updating(data: $data)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SessionAsyncDataUpdating<E, D> && data == other.data);

  @override
  int get hashCode => data.hashCode;
}

// --- Error --- //

@immutable
@sealed
class SessionAsyncDataError<E extends Object?, D extends Object?>
    extends SessionAsyncData<E, D> {
  @override
  final D data;
  @override
  final E error;

  const SessionAsyncDataError({
    required this.error,
    required this.data,
  }) : super._();

  @override
  bool get isInitial => false;

  @override
  bool get isConnecting => false;

  @override
  bool get isIdle => false;

  @override
  bool get isUpdating => false;

  @override
  bool get isError => true;

  @override
  bool get isFatalError => false;

  @override
  SessionAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      SessionAsyncDataError(
        error: error,
        data: mapper(data),
      );

  @override
  SessionAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      SessionAsyncDataError(
        error: mapper(error),
        data: data,
      );

  @override
  SessionAsyncData<E, B> flatMap<B extends Object?>(
    SessionAsyncData<E, B> Function(D data) mapper,
  ) =>
      mapper(data);

  @override
  R match<R>({
    required R Function(SessionAsyncDataInitial data) initial,
    required R Function(SessionAsyncDataConnecting data) connecting,
    required R Function(SessionAsyncDataIdle<E, D> data) idle,
    required R Function(SessionAsyncDataUpdating<E, D> data) updating,
    required R Function(SessionAsyncDataError<E, D> data) error,
    required R Function(SessionAsyncDataFatalError<E, D> data) fatalError,
  }) =>
      error(this);

  @override
  R matchOr<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
    required R Function() fallback,
  }) =>
      error?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
  }) =>
      error?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() connecting,
    required R Function(D data) idle,
    required R Function(D data) updating,
    required R Function(E error, D data) error,
    required R Function(E error) fatalError,
  }) =>
      error(this.error, data);

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
    required R Function() fallback,
  }) =>
      error?.call(this.error, data) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
  }) =>
      error?.call(this.error, data);

  @override
  String toString() => 'SessionAsyncData.error(error: $error, data: $data)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SessionAsyncDataError<E, D> &&
          data == other.data &&
          error == other.error);

  @override
  int get hashCode => data.hashCode ^ error.hashCode;
}

// --- Fatal error --- //

@immutable
@sealed
class SessionAsyncDataFatalError<E extends Object?, D extends Object?>
    extends SessionAsyncData<E, D> {
  @override
  final E error;

  const SessionAsyncDataFatalError({required this.error}) : super._();

  @override
  D? get data => null;

  @override
  bool get isInitial => false;

  @override
  bool get isConnecting => false;

  @override
  bool get isIdle => false;

  @override
  bool get isUpdating => false;

  @override
  bool get isError => false;

  @override
  bool get isFatalError => true;

  @override
  SessionAsyncData<E, B> map<B extends Object?>(
    B Function(D data) mapper,
  ) =>
      SessionAsyncDataFatalError(error: error);

  @override
  SessionAsyncData<A, D> mapError<A extends Object?>(
    A Function(E error) mapper,
  ) =>
      SessionAsyncDataFatalError(
        error: mapper(error),
      );

  @override
  SessionAsyncData<E, B> flatMap<B extends Object?>(
    SessionAsyncData<E, B> Function(D data) mapper,
  ) =>
      SessionAsyncDataFatalError(error: error);

  @override
  R match<R>({
    required R Function(SessionAsyncDataInitial data) initial,
    required R Function(SessionAsyncDataConnecting data) connecting,
    required R Function(SessionAsyncDataIdle<E, D> data) idle,
    required R Function(SessionAsyncDataUpdating<E, D> data) updating,
    required R Function(SessionAsyncDataError<E, D> data) error,
    required R Function(SessionAsyncDataFatalError<E, D> data) fatalError,
  }) =>
      fatalError(this);

  @override
  R matchOr<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
    required R Function() fallback,
  }) =>
      fatalError?.call(this) ?? fallback();

  @override
  R? matchOrNull<R>({
    R Function(SessionAsyncDataInitial data)? initial,
    R Function(SessionAsyncDataConnecting data)? connecting,
    R Function(SessionAsyncDataIdle<E, D> data)? idle,
    R Function(SessionAsyncDataUpdating<E, D> data)? updating,
    R Function(SessionAsyncDataError<E, D> data)? error,
    R Function(SessionAsyncDataFatalError<E, D> data)? fatalError,
  }) =>
      fatalError?.call(this);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() connecting,
    required R Function(D data) idle,
    required R Function(D data) updating,
    required R Function(E error, D data) error,
    required R Function(E error) fatalError,
  }) =>
      fatalError(this.error);

  @override
  R whenOr<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
    required R Function() fallback,
  }) =>
      fatalError?.call(this.error) ?? fallback();

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? idle,
    R Function(D data)? updating,
    R Function(E error, D data)? error,
    R Function(E error)? fatalError,
  }) =>
      fatalError?.call(this.error);

  @override
  String toString() => 'SessionAsyncData.fatalError(error: $error)';

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SessionAsyncDataFatalError<E, D> && error == other.error);

  @override
  int get hashCode => error.hashCode;
}
