part of 'check_username_cubit.dart';

sealed class CheckUsernameState extends Equatable {
  const CheckUsernameState();
  @override
  List<Object> get props => [];
}

// there is a previous username
final class CheckUsernameInitial extends CheckUsernameState {
  final String username;
  const CheckUsernameInitial({ required this.username});
}

// there is no previous username
final class CheckUsernameInitialEmpty extends CheckUsernameState {}

final class CheckUsernameLoaded extends CheckUsernameState {
  final String username;

  const CheckUsernameLoaded(this.username);

  @override
  List<Object> get props => [username];
}

final class CheckUsernameLoading extends CheckUsernameState {
  final String valueToCheck;

  const CheckUsernameLoading(this.valueToCheck);

  @override
  List<Object> get props => [valueToCheck];
}

final class CheckUsernameError extends CheckUsernameState {
  final String message;

  const CheckUsernameError(this.message);

  @override
  List<Object> get props => [message];
}
