import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/core/failures.dart';
import 'package:modawan/core/modawan_api.dart';
import 'package:modawan/features/profile/repository/profile_model.dart';
import 'package:modawan/main.dart';

class ProfileRepository {
  Future<Either<Failure, String>> updateProfileImage({required String userID, required XFile image}) async {
    final distPath =
        '$userID/profile${DateTime.now().millisecondsSinceEpoch}.png';
    final result = await Modawanapi.uploadImage(
      bucketName: 'avatars',
      distPath: distPath,
      image: image,
    );

    return result;
  }

 Future<Either<Failure, void>> deleteProfileImage({required String userID, required String distPath}) async {
    final result = await Modawanapi.deleteImage(
      bucketName: 'avatars',
      distPath: distPath,
    );

    return result;
  }

  retrieveImageUrl({required String distPath}) {
    return supabase.storage.from('avatars').getPublicUrl(distPath);
  }

  /* no need for add or delete profile record because
    it will be done automatically when the user sign up or delete his account */

  updateProfile({required String userID, required ProfileModel data}) {
    return supabase.from('profiles').update(data.toMap()).eq('user_id', userID);
  }
}
