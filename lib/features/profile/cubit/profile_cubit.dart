import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:modawan/features/profile/repository/profile_repository.dart';

import '../repository/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  final ProfileRepository _profileRepository;

  Future<bool> isFinishSetup(String userID) async {

    if (state is ProfileLoaded) {
      return (state as ProfileLoaded).profile.finishSteup;
    }
    final profile = await retrieveProfile(userID);
    print('this is profile ${profile}');
    if (profile != null) {
      return profile.finishSteup;
    }
    return true;
  }

  Future<void> updateProfile(ProfileModel profile) async {
    emit(ProfileLoading());
    final res = await _profileRepository.updateProfile(data: profile);
    res.fold(
      (l) => emit(ProfileError(l.message)),
      (r) => emit(ProfileLoaded(profile)),
    );
  }

  Future<ProfileModel?> retrieveProfile(String userID) async {
    emit(ProfileLoading());

    final cached = await _profileRepository.retrieveCachedProfile(userID);
    bool cachedSuccessed = false;
    ProfileModel? profile;
    cached.fold(
      (l) {},
      (r) {
        profile = r;
        emit(ProfileLoaded(r));
        cachedSuccessed = true;
      },
    );
    // this is to update the cache in both cases of success or failure
    final res = await _profileRepository.retrieveProfile(userID);
                            print('this is finish sssssssssa ');

    res.fold(
      (l) {
        if (!cachedSuccessed) emit(ProfileError(l.message));
      },
      (r) {
        // make sure that equatable is implemented in the ProfileModel
        // to avoid emitting the same state
        profile = r;
        emit(ProfileLoaded(r));
      },
    );
    return profile;
  }
}
