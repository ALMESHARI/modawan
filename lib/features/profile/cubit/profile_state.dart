part of 'profile_cubit.dart';

@immutable
sealed class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded(this.profile);
  
  @override
  List<Object?> get props => [profile];
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
  
  @override
  List<Object?> get props => [message];
}
