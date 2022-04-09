import 'package:meta/meta.dart';

// --- Abstract --- //

@immutable
@sealed
abstract class Either<L, R> {
  const Either._();

  const factory Either.left(L left) = Left;

  const factory Either.right(R right) = Right;

  factory Either.fromNullable(R? right, L Function() onNull) =>
      right == null ? Left(onNull()) : Right(right);

  factory Either.tryCatch(
    R Function() body,
    L Function(Object error, StackTrace stackTrace) onError,
  ) {
    try {
      final right = body();

      return Right(right);
    } on Object catch (e, s) {
      final left = onError(e, s);

      return Left(left);
    }
  }

  L? get left;

  R? get right;

  bool get isLeft;

  bool get isRight;

  Either<L, B> map<B>(B Function(R right) mapper);

  Either<A, R> mapLeft<A>(A Function(L left) mapper);

  Either<L, B> flatMap<B>(Either<L, B> Function(R right) mapper);

  T match<T>({
    required T Function(Left<L, R> either) left,
    required T Function(Right<L, R> either) right,
  });

  T matchOr<T>({
    T Function(Left<L, R> either)? left,
    T Function(Right<L, R> either)? right,
    required T Function() fallback,
  });

  T? matchOrNull<T>({
    T Function(Left<L, R> either)? left,
    T Function(Right<L, R> either)? right,
  });

  T when<T>({
    required T Function(L left) left,
    required T Function(R right) right,
  });

  T whenOr<T>({
    T Function(L left)? left,
    T Function(R right)? right,
    required T Function() fallback,
  });

  T? whenOrNull<T>({
    T Function(L left)? left,
    T Function(R right)? right,
  });
}

// --- Left --- //

@immutable
@sealed
class Left<L, R> extends Either<L, R> {
  @override
  final L left;

  const Left(this.left) : super._();

  @override
  R? get right => null;

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  Either<L, B> map<B>(B Function(R right) mapper) => Left(left);

  @override
  Either<A, R> mapLeft<A>(A Function(L left) mapper) => Left(mapper(left));

  @override
  Either<L, B> flatMap<B>(Either<L, B> Function(R right) mapper) => Left(left);

  @override
  T match<T>({
    required T Function(Left<L, R> either) left,
    required T Function(Right<L, R> either) right,
  }) =>
      left(this);

  @override
  T matchOr<T>({
    T Function(Left<L, R> either)? left,
    T Function(Right<L, R> either)? right,
    required T Function() fallback,
  }) =>
      left?.call(this) ?? fallback();

  @override
  T? matchOrNull<T>({
    T Function(Left<L, R> either)? left,
    T Function(Right<L, R> either)? right,
  }) =>
      left?.call(this);

  @override
  T when<T>({
    required T Function(L left) left,
    required T Function(R right) right,
  }) =>
      left(this.left);

  @override
  T whenOr<T>({
    T Function(L left)? left,
    T Function(R right)? right,
    required T Function() fallback,
  }) =>
      left?.call(this.left) ?? fallback();

  @override
  T? whenOrNull<T>({
    T Function(L left)? left,
    T Function(R right)? right,
  }) =>
      left?.call(this.left);

  @override
  String toString() => 'Left($left)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Left<L, R> && left == other.left);

  @override
  int get hashCode => left.hashCode;
}

// --- Right --- //

@immutable
@sealed
class Right<L, R> extends Either<L, R> {
  @override
  final R right;

  const Right(this.right) : super._();

  @override
  L? get left => null;

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  Either<L, B> map<B>(B Function(R right) mapper) => Right(mapper(right));

  @override
  Either<A, R> mapLeft<A>(A Function(L left) mapper) => Right(right);

  @override
  Either<L, B> flatMap<B>(Either<L, B> Function(R right) mapper) =>
      mapper(right);

  @override
  T match<T>({
    required T Function(Left<L, R> either) left,
    required T Function(Right<L, R> either) right,
  }) =>
      right(this);

  @override
  T matchOr<T>({
    T Function(Left<L, R> either)? left,
    T Function(Right<L, R> either)? right,
    required T Function() fallback,
  }) =>
      right?.call(this) ?? fallback();

  @override
  T? matchOrNull<T>({
    T Function(Left<L, R> either)? left,
    T Function(Right<L, R> either)? right,
  }) =>
      right?.call(this);

  @override
  T when<T>({
    required T Function(L left) left,
    required T Function(R right) right,
  }) =>
      right(this.right);

  @override
  T whenOr<T>({
    T Function(L left)? left,
    T Function(R right)? right,
    required T Function() fallback,
  }) =>
      right?.call(this.right) ?? fallback();

  @override
  T? whenOrNull<T>({
    T Function(L left)? left,
    T Function(R right)? right,
  }) =>
      right?.call(this.right);

  @override
  String toString() => 'Right($right)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Right<L, R> && right == other.right);

  @override
  int get hashCode => right.hashCode;
}
