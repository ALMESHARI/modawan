part of 'image_uplader_cubit.dart';

sealed class ImageUpladerState extends Equatable {
  const ImageUpladerState();

  @override
  List<Object> get props => [];
}

final class ImageUpladerInitial extends ImageUpladerState {}

final class ImageUpladerLoading extends ImageUpladerState {}

final class ImageUpladerLoaded extends ImageUpladerState {
  final String url;

  ImageUpladerLoaded(this.url);

  @override
  List<Object> get props => [url];
}

final class ImageUpladerError extends ImageUpladerState {
  final String message;

  ImageUpladerError(this.message);

  @override
  List<Object> get props => [message];
}
