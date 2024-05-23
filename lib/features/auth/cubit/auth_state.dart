part of 'auth_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthInitial extends AuthCubitState {}

final class Unauthenticated extends AuthCubitState {}

final class Authenticated extends AuthCubitState {}

final class AuthFailure extends AuthCubitState {
  final Failure failure;

  AuthFailure(this.failure);
}
