part of 'check_username_cubit.dart';

sealed class CheckUsernameState extends Equatable {
  const CheckUsernameState();

  @override
  List<Object> get props => [];
}

final class CheckUsernameInitial extends CheckUsernameState {}

final class CheckUsernameLoaded extends CheckUsernameState {
  final String username;

  CheckUsernameLoaded(this.username);

  @override
  List<Object> get props => [username];
}

final class CheckUsernameLoading extends CheckUsernameState {
  final String valueToCheck;

  CheckUsernameLoading(this.valueToCheck);

  @override
  List<Object> get props => [valueToCheck];
}

final class CheckUsernameError extends CheckUsernameState {
  final String message;

  CheckUsernameError(this.message);

  @override
  List<Object> get props => [message];
}
