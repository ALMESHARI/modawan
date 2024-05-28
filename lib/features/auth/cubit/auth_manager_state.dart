part of 'auth_manager_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthInitial extends AuthCubitState {}

final class AuthLoading extends AuthCubitState {}


final class AuthSuccess extends AuthCubitState {}

final class AuthFailure extends AuthCubitState {
  final Failure failure;

  AuthFailure(this.failure);
}
