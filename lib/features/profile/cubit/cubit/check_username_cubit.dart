import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:modawan/features/profile/repository/profile_repository.dart';

import '../../repository/profile_model.dart';
import '../profile_cubit.dart';

part 'check_username_state.dart';

class CheckUsernameCubit extends Cubit<CheckUsernameState> {
  CheckUsernameCubit(this.username, this.profileRepository)
      : super(CheckUsernameInitial()) {
    if (username != null && username!.isNotEmpty) {
      emit(CheckUsernameLoaded(username!));
    }
  }
  final profileCubit = GetIt.I.get<ProfileCubit>();
  final ProfileRepository profileRepository;
  String? username;

  Future<void> uploadWithNewName(ProfileModel profile, controller) async {
    if (profile.username!.isEmpty) {
      if (username != null && username!.isNotEmpty) {
        emit(CheckUsernameLoaded(username!));
        return;
      }
      emit(CheckUsernameError('username is empty'));
      return;
    }
    final valueToCheck = profile.username;
    emit(CheckUsernameLoading(valueToCheck ?? ''));
    await Future.delayed(const Duration(seconds: 2));
    if (valueToCheck != controller.text.trim()) {
      return;
    }
    print('checking username $valueToCheck');
    final res = await profileRepository.updateProfile(data: profile);

    res.fold(
      (l) => emit(CheckUsernameError('username @${profile.username} is taken')),
      (r) async {
        username = r.username;
        emit(CheckUsernameLoaded(r.username ?? ''));
        await profileCubit.updateCachedProfile(r, false);
      },
    );
  }
}
