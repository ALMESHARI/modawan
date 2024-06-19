import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/core/failures.dart';
import 'package:modawan/core/modawan_api.dart';

part 'image_uplader_state.dart';

class ImageUpladerCubit extends Cubit<ImageUpladerState> {
  ImageUpladerCubit(this.bucketName, this.distPath, this.currentUrl, this.onUpdated)
      : super(ImageUpladerInitial());
  final String bucketName;
  final String distPath;
  String currentUrl;
  final Function(String newUrl)? onUpdated;

  Future<void> uploadImage({required XFile image}) async {
    emit(ImageUpladerLoading());
    try {
      final newUrl = await Modawanapi.uploadImage(
        bucketName: bucketName,
        distPath: distPath,
        image: image,
      );
      currentUrl = newUrl;
      emit(ImageUpladerLoaded(newUrl));
      onUpdated?.call(newUrl);
    } catch (e) {
      emit(ImageUpladerError(getFailureFromException(e).message));
    }
  }
}
