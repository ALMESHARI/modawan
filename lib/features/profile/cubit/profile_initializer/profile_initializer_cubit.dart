import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:modawan/features/profile/repository/profile_repository.dart';

import '../../repository/profile_model.dart';

part 'profile_initializer_state.dart';

class ProfileInitializerCubit extends Cubit<ProfileInitializerState> {
  ProfileInitializerCubit(this._profileRepository) : super(ProfileInitializerLoading());

  final ProfileRepository _profileRepository;

  Future<void> getProfile(String userID) async {
    emit(ProfileInitializerLoading());
    final res = await _profileRepository.retrieveProfile(userID);
    res.fold(
      (l) => emit(ProfileInitializerError(l.message)),
      (r) => emit(ProfileInitializerLoaded(r)),
    );
  }
}
