part of 'auth_manager_cubit.dart';

@immutable
sealed class AuthManagerCubitState {}

final class AuthInitial extends AuthManagerCubitState {}

final class AuthLoading extends AuthManagerCubitState {}

final class AuthSuccess extends AuthManagerCubitState {}

final class AuthOTPSent extends AuthManagerCubitState {
  final String emailAddress;

  AuthOTPSent(this.emailAddress);
}

final class AuthFailure extends AuthManagerCubitState {
  final Failure failure;

  AuthFailure(this.failure);
}
