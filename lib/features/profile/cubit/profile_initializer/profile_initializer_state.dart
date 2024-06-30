part of 'profile_initializer_cubit.dart';

sealed class ProfileInitializerState extends Equatable {
  const ProfileInitializerState();

  @override
  List<Object> get props => [];
}

final class ProfileInitializerLoading extends ProfileInitializerState {}

final class ProfileInitializerLoaded extends ProfileInitializerState {
  final ProfileModel profile;
  const ProfileInitializerLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

final class ProfileInitializerError extends ProfileInitializerState {
  final String message;
  const ProfileInitializerError(this.message);

  @override
  List<Object> get props => [message];
}
