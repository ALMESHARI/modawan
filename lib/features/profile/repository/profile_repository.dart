import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/core/failures.dart';
import 'package:modawan/core/modawan_api.dart';
import 'package:modawan/features/profile/repository/profile_model.dart';
import 'package:modawan/main.dart';

class ProfileRepository {
  Future<Either<Failure, String>> updateProfileImage(
      {required String userID, required XFile image}) async {
    try {
      final distPath =
          '$userID/profile${DateTime.now().millisecondsSinceEpoch}.png';
      final result = await Modawanapi.uploadImage(
        bucketName: 'avatars',
        distPath: distPath,
        image: image,
      );
      return Right(result);
    } catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  String retrieveImageUrl({required String distPath}) {
    return supabase.storage.from('avatars').getPublicUrl(distPath);
  }

  /* no need for add or delete profile record because
    it will be done automatically when the user sign up or delete his account */

  Future<Either<Failure, ProfileModel>> updateProfile(
      {required ProfileModel data}) async {
    // remove the url from avatar before updating the profile
    if (data.avatar != null) {
      data = data.copyWith(avatar: null);
    }
    try {
      final res = await supabase
          .from('profiles')
          .update(data.toMap())
          .eq('user_id', data.userID)
          .select();
      await Modawanapi.putInCache('profiles', data.userID, res[0]);
      // add avatarURL key to res map
      if (res[0]['avatar'] != null) {
        res[0]['avatarURL'] = retrieveImageUrl(distPath: res[0]['avatar']);
      }

      return Right(ProfileModel.fromMap(res[0]));
    } catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  Future<Either<Failure, ProfileModel>> retrieveCachedProfile(
      String userID) async {
    try {
      final cached = await Modawanapi.fetchFromCache('profiles', userID);
      if (cached != null) {
        if (cached['avatar'] != null) {
          cached['avatarURL'] = retrieveImageUrl(distPath: cached['avatar']);
        }
        return Right(ProfileModel.fromMap(cached as Map<String, dynamic>));
      }

      return Left(getFailure('No cached profile found'));
    } catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  Future<Either<Failure, ProfileModel>> retrieveProfile(String userID) async {
    try {
      final result =
          await supabase.from('profiles').select().eq('user_id', userID);

      ProfileModel profile = ProfileModel.fromMap(result[0]);
      if (profile.avatar != null) {
        profile = profile.copyWith(
          avatarURL: retrieveImageUrl(distPath: profile.avatar!),
        );
      } else {
        profile = profile.copyWith(avatar: null);
      }

      await Modawanapi.putInCache('profiles', userID, profile.toMap());
      print('profile: $profile');
      return Right(profile);
    } catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  //update the cache with the new profile
  Future<Either<Failure, ProfileModel>> updateCachedProfile(
      ProfileModel profile) async {
    try {
      await Modawanapi.putInCache('profiles', profile.userID, profile.toMap());
      return Right(profile);
    } catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  Future<Either<Failure, bool>> checkUsernameAvailability(
      String newUsername) async {
    try {
      await supabase
          .from('temp_reserved_usernames')
          .insert({'username': newUsername});
      return const Right(true);
    } catch (e) {
      if (e.toString().contains('already taken') || e.toString().contains('unique constraint')) {
        return const Right(false);
      }
      return Left(getFailureFromException(e));
    }
  }
}
