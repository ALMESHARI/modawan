import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:modawan/features/profile/repository/profile_repository.dart';
part 'check_username_state.dart';

class CheckUsernameCubit extends Cubit<CheckUsernameState> {
  CheckUsernameCubit(this.username, this.profileRepository)
      : super(username != null
            ? CheckUsernameInitial(username: username)
            : CheckUsernameInitialEmpty());
  final ProfileRepository profileRepository;
  String? username;

  Future<void> checkUsernameAvailability(String newUsername, controller) async {
    if (newUsername.isEmpty) {
      if (username != null && username!.isNotEmpty) {
        emit(CheckUsernameLoaded(username!));
        return;
      }
      emit(const CheckUsernameError('username is empty'));
      return;
    }
    final valueToCheck = newUsername;
    emit(CheckUsernameLoading(valueToCheck));
    await Future.delayed(const Duration(seconds: 2));
    if (valueToCheck != controller.text.trim()) {
      return;
    }
    print('checking username $valueToCheck');
    final res = await profileRepository.checkUsernameAvailability(valueToCheck);

    res.fold(
      (l) => emit(const CheckUsernameError('Something went wrong')),
      (isAvailable) async {
        if (isAvailable) {
          emit(CheckUsernameLoaded(valueToCheck));
        } else {
          emit(CheckUsernameError('Username $valueToCheck is not available'));
        }
      },
    );
  }
}
