import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/main.dart';

class Modawanapi {
  static Future<String> uploadImage(
      {required String bucketName,
      required String distPath,
      required XFile image}) async {
    final gg = await supabase.storage
        .from(bucketName)
        .uploadBinary(distPath, await image.readAsBytes());
    return supabase.storage.from(bucketName).getPublicUrl(distPath);
  }

  static Future<void> deleteImage(
      {required String bucketName, required String distPath}) async {
    await supabase.storage.from(bucketName).remove([distPath]);
    return;
  }

  // // fetch data from the database
  // static Future<List<Map<String, dynamic>>> fetchData(
  //     {required Function query, String? cacheKey}) async {
  //   final response = await query();
  //   return response;
  // }

  // put data in cache
  static Future<void> putInCache(
      String boxName, String cacheKey, dynamic data) async {
    final box = await Hive.openBox(boxName);
    await box.put(cacheKey, data);
  }

  // fetch from cache
  // this function is not responsible for casting the data to the desired type
  static Future<dynamic> fetchFromCache(String boxName, String cacheKey) async {
    final box = await Hive.openBox(boxName);
    final data = box.get(cacheKey);
    if (data == null) return null;
    return data.cast<String, dynamic>();
  }
}
