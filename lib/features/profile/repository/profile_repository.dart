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

  Future<Either<Failure, void>> deleteProfileImage(
      {required String userID, required String distPath}) async {
    try {
      final result = await Modawanapi.deleteImage(
        bucketName: 'avatars',
        distPath: distPath,
      );
      return Right(result);
    } catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  retrieveImageUrl({required String distPath}) {
    return supabase.storage.from('avatars').getPublicUrl(distPath);
  }

  /* no need for add or delete profile record because
    it will be done automatically when the user sign up or delete his account */

  Future<Either<Failure, ProfileModel>> updateProfile(
      {required ProfileModel data}) async {
    try {
      final res = await supabase
          .from('profiles')
          .update(data.toMap())
          .eq('user_id', data.userID);
      print(res);
      await Modawanapi.putInCache('profiles', data.userID, data.toMap());
      return Right(ProfileModel.fromMap(res));
    } catch (e) {
      return Left(getFailureFromException(e));
    }
  }

  Future<Either<Failure, ProfileModel>> retrieveCachedProfile(
      String userID) async {
    try {
      final cached = await Modawanapi.fetchFromCache('profiles', userID);
      if (cached != null) {
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
          avatar: await retrieveImageUrl(distPath: profile.avatar!),
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
  Future<void> updateCachedProfile(ProfileModel profile) async {
    await Modawanapi.putInCache('profiles', profile.userID, profile.toMap());
  }
}
