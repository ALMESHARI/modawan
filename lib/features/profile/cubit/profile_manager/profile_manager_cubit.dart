import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:modawan/features/profile/repository/profile_repository.dart';
import '../../repository/profile_model.dart';
part 'profile_manager_state.dart';

class ProfileManager extends Cubit<ProfileManagerState> {
  ProfileManager(ProfileModel current,this._profileRepository) : super(ProfileManagerLoaded(profile: current));

  final ProfileRepository _profileRepository;

  Future<void> updateProfile(ProfileModel profile) async {
    emit(ProfileManagerLoading(profile: state.profile));
    final res = await _profileRepository.updateProfile(data: profile);
    res.fold((l) {
      emit(ProfileManagerError(profile: state.profile,message: l.message));
    }, (r) {
      emit(ProfileManagerLoaded(profile:r));
    });
  }

  Future<void> updateOnlyCache(ProfileModel profile) async {
    // emit(ProfileManagerLoading(profile: state.profile));
    final res = await _profileRepository.updateCachedProfile( profile);
    res.fold((l) {
      emit(ProfileManagerError(profile: state.profile,message: l.message));
    }, (r) {
      emit(ProfileManagerLoaded(profile:r));
    });
  }
}
