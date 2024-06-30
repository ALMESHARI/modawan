part of 'profile_manager_cubit.dart';

@immutable
sealed class ProfileManagerState extends Equatable {
  final ProfileModel profile;
  const ProfileManagerState({required this.profile});
}

final class ProfileManagerLoading extends ProfileManagerState {
  const ProfileManagerLoading({required super.profile});
  @override
  List<Object?> get props => [profile];
}

final class ProfileManagerLoaded extends ProfileManagerState {
  const ProfileManagerLoaded({required super.profile});
  @override
  List<Object?> get props => [profile];
}

final class ProfileManagerError extends ProfileManagerState {
  final String message;
  const ProfileManagerError({required super.profile, required this.message});

  @override
  List<Object?> get props => [profile, message];
}
