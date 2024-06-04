import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/core/failures.dart';
import 'package:modawan/main.dart';

class Modawanapi {
  static Future<Either<Failure, String>> uploadImage(
      {required String bucketName,
      required String distPath,
      required XFile image}) async {
    try {
      await supabase.storage
          .from(bucketName)
          .uploadBinary(distPath, await image.readAsBytes());
      String url = supabase.storage.from(bucketName).getPublicUrl(distPath);
      return Right(url);
    } catch (e) {
      return Left(getFailureFromException(e as Exception));
    }
  }

  static Future<Either<Failure, void>> deleteImage(
      {required String bucketName, required String distPath}) async {
    try {
      await supabase.storage.from(bucketName).remove([distPath]);
      return const Right(null);
    } catch (e) {
      return Left(getFailureFromException(e as Exception));
    }
  }
}
