part of 'auth_loading_cubit.dart';

@immutable
sealed class AuthLoadingState {}

final class AuthLoadingInProgress extends AuthLoadingState {}

final class AuthLoadingComplete extends AuthLoadingState{}
