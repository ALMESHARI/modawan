import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/core/components/image_helper/image_viewer.dart';
import 'package:modawan/core/failures.dart';
import 'package:modawan/core/modawan_api.dart';

part 'image_uplader_state.dart';

class ImageUpladerCubit extends Cubit<ImageUpladerState> {
  ImageUpladerCubit(this.currentUrl, this.updateInforamtion)
      : super(ImageUpladerInitial());

  String currentUrl;
  final UpdateInforamtion updateInforamtion;

  Future<void> uploadImage({required XFile image}) async {
    if (updateInforamtion.distPathGenerator == null && updateInforamtion.distpath == null) {
      emit(ImageUpladerError('distPathGenerator or distpath must be provided'));
      return;
    }
    emit(ImageUpladerLoading());
    try {
      final dist = updateInforamtion.distpath ?? updateInforamtion.distPathGenerator!();
      final newUrl = await Modawanapi.uploadImage(
        bucketName: updateInforamtion.bucketName,
        distPath: dist,
        image: image,
      );
      currentUrl = newUrl;
      emit(ImageUpladerLoaded(newUrl));
      updateInforamtion.onUpdated?.call(dist);
    } catch (e) {
      updateInforamtion.onFailed?.call(getFailureFromException(e).message);
      emit(ImageUpladerError(getFailureFromException(e).message));
    }
  }
}
