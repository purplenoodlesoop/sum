import 'package:meta/meta.dart';

@immutable
@sealed
abstract class Maybe<A> {
  const Maybe._();

  @literal
  const factory Maybe.nothing() = Nothing;

  const factory Maybe.just(A value) = Just;

  factory Maybe.fromNullable(A? value) {
    if (value == null) return const Nothing();
    return Just(value);
  }

  A? get value;

  bool get isNothing;

  bool get isJust;

  Maybe<B> map<B>(B Function(A value) mapper);

  Maybe<B> flatMap<B>(Maybe<B> Function(A value) mapper);

  Maybe<B> nullableMap<B>(B? Function(A value) mapper);

  T match<T>({
    required T Function(Nothing maybe) nothing,
    required T Function(Just<A> maybe) just,
  });

  T matchOr<T>({
    T Function(Nothing maybe)? nothing,
    T Function(Just<A> maybe)? just,
    required T Function() fallback,
  });

  T? matchOrNull<T>({
    T Function(Nothing maybe)? nothing,
    T Function(Just<A> maybe)? just,
  });

  T when<T>({
    required T Function() nothing,
    required T Function(A value) just,
  });

  T whenOr<T>({
    T Function()? nothing,
    T Function(A value)? just,
    required T Function() fallback,
  });

  T? whenOrNull<T>({
    T Function()? nothing,
    T Function(A value)? just,
  });
}

// --- Nothing --- //

@immutable
@sealed
class Nothing<A> extends Maybe<A> {
  @literal
  const Nothing() : super._();

  @override
  A? get value => null;

  @override
  bool get isNothing => true;

  @override
  bool get isJust => false;

  @override
  Maybe<B> map<B>(B Function(A value) mapper) => const Nothing();

  @override
  Maybe<B> flatMap<B>(Maybe<B> Function(A value) mapper) => const Nothing();

  @override
  Maybe<B> nullableMap<B>(B? Function(A value) mapper) => const Nothing();

  @override
  T match<T>({
    required T Function(Nothing maybe) nothing,
    required T Function(Just<A> maybe) just,
  }) =>
      nothing(this);

  @override
  T matchOr<T>({
    T Function(Nothing maybe)? nothing,
    T Function(Just<A> maybe)? just,
    required T Function() fallback,
  }) =>
      nothing?.call(this) ?? fallback();

  @override
  T? matchOrNull<T>({
    T Function(Nothing maybe)? nothing,
    T Function(Just<A> maybe)? just,
  }) =>
      nothing?.call(this);

  @override
  T when<T>({
    required T Function() nothing,
    required T Function(A value) just,
  }) =>
      nothing();

  @override
  T whenOr<T>({
    T Function()? nothing,
    T Function(A value)? just,
    required T Function() fallback,
  }) =>
      nothing?.call() ?? fallback();

  @override
  T? whenOrNull<T>({
    T Function()? nothing,
    T Function(A value)? just,
  }) =>
      nothing?.call();

  @override
  String toString() => 'Nothing()';

  @override
  bool operator ==(Object? other) =>
      identical(this, other) || other is Nothing<A>;

  @override
  int get hashCode => runtimeType.hashCode;
}

// --- Just --- //

@immutable
@sealed
class Just<A> extends Maybe<A> {
  @override
  final A value;

  const Just(this.value) : super._();

  @override
  bool get isNothing => false;

  @override
  bool get isJust => true;

  @override
  Maybe<B> map<B>(B Function(A value) mapper) => Just(mapper(value));

  @override
  Maybe<B> flatMap<B>(Maybe<B> Function(A value) mapper) => mapper(value);

  @override
  Maybe<B> nullableMap<B>(B? Function(A value) mapper) => Maybe.fromNullable(
        mapper(value),
      );

  @override
  T match<T>({
    required T Function(Nothing maybe) nothing,
    required T Function(Just<A> maybe) just,
  }) =>
      just(this);

  @override
  T matchOr<T>({
    T Function(Nothing maybe)? nothing,
    T Function(Just<A> maybe)? just,
    required T Function() fallback,
  }) =>
      just?.call(this) ?? fallback();

  @override
  T? matchOrNull<T>({
    T Function(Nothing maybe)? nothing,
    T Function(Just<A> maybe)? just,
  }) =>
      just?.call(this);

  @override
  T when<T>({
    required T Function() nothing,
    required T Function(A value) just,
  }) =>
      just(value);

  @override
  T whenOr<T>({
    T Function()? nothing,
    T Function(A value)? just,
    required T Function() fallback,
  }) =>
      just?.call(value) ?? fallback();

  @override
  T? whenOrNull<T>({
    T Function()? nothing,
    T Function(A value)? just,
  }) =>
      just?.call(value);

  @override
  String toString() => 'Just($value)';

  @override
  bool operator ==(Object? other) =>
      identical(this, other) || (other is Just<A> && value == other.value);

  @override
  int get hashCode => value.hashCode;
}
