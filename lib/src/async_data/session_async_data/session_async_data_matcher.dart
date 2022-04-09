// ignore_for_file: null_check_on_nullable_type_parameter

import 'package:meta/meta.dart';

@immutable
class SessionAsyncDataMatcher<E extends Object?, D extends Object?> {
  final bool _isInitial;
  final bool _isConnecting;
  final bool _isOperational;
  final bool _isFatalError;
  final D? _data;
  final E? _error;

  const SessionAsyncDataMatcher({
    required bool isInitial,
    required bool isConnecting,
    required bool isOperational,
    required bool isFatalError,
    D? data,
    E? error,
  })  : _isInitial = isInitial,
        _isConnecting = isConnecting,
        _isOperational = isOperational,
        _isFatalError = isFatalError,
        _data = data,
        _error = error;

  Never _throwInvalidPredicatesStateError() {
    throw StateError(
      'Invalid state in SessionAsyncDataMatcher. It is probably an internal '
      'error that should be reported to the developer as a GitHub issue.',
    );
  }

  R when<R>({
    required R Function() initial,
    required R Function() connecting,
    required R Function(D data) operational,
    required R Function(E error) fatalError,
  }) {
    if (_isInitial) return initial();
    if (_isConnecting) return connecting();
    if (_isOperational) return operational(_data!);
    if (_isFatalError) return fatalError(_error!);
    _throwInvalidPredicatesStateError();
  }

  R whenOr<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? operational,
    R Function(E error)? fatalError,
    required R Function() fallback,
  }) {
    if (_isInitial) return initial?.call() ?? fallback();
    if (_isConnecting) return connecting?.call() ?? fallback();
    if (_isOperational) return operational?.call(_data!) ?? fallback();
    if (_isFatalError) return fatalError?.call(_error!) ?? fallback();
    _throwInvalidPredicatesStateError();
  }

  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? connecting,
    R Function(D data)? operational,
    R Function(E error)? fatalError,
  }) {
    if (_isInitial) return initial?.call();
    if (_isConnecting) return connecting?.call();
    if (_isOperational) return operational?.call(_data!);
    if (_isFatalError) return fatalError?.call(_error!);
    _throwInvalidPredicatesStateError();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionAsyncDataMatcher &&
          _isInitial == other._isInitial &&
          _isConnecting == other._isConnecting &&
          _isOperational == other._isOperational &&
          _isFatalError == other._isFatalError &&
          _data == other._data);

  @override
  int get hashCode =>
      _isInitial.hashCode ^
      _isConnecting.hashCode ^
      _isOperational.hashCode ^
      _isFatalError.hashCode ^
      _data.hashCode;

  @override
  String toString() => 'SessionAsyncDataMatcher { '
      'isInitial: $_isInitial, '
      'isConnecting: $_isConnecting, '
      'isOperational: $_isOperational, '
      'isFatalError: $_isFatalError, '
      'data: $_data, '
      'error: $_error'
      '}';
}
