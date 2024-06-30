import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/core/components/image_helper/cubit/image_uplader_cubit.dart';
import 'package:modawan/core/components/image_helper/image_picker_helper.dart';
import 'package:modawan/core/theme/theme_constants.dart';

class UpdateInforamtion {
  final String? distpath;
  final String bucketName;
  final String Function()? distPathGenerator;
  Future<void> Function(String newUrl)? onUpdated;
  Future<void> Function(String error)? onFailed;

  UpdateInforamtion(
      {this.distpath,
      required this.bucketName,
      this.distPathGenerator,
      this.onUpdated,
      this.onFailed});
}

class ImageViewer extends StatelessWidget {
  final Widget placeholder; // when error occurs
  final Widget loadingWidget; // first load
  final Widget updatingWidget; // when updating
  final bool useCache;
  final String? imageUrl;
  final XFile? imageFile;
  final bool viewMode;
  final String? title;
  final UpdateInforamtion? updateInformation;
  final String? heroAnimationKey; // for image update

// put default values in this constructor
  const ImageViewer(
      {super.key,
      this.imageUrl = '',
      this.placeholder = const DefaultPlaceHolder(),
      this.loadingWidget = const DefaultLoadingWidget(),
      this.updatingWidget = const DefaultUpdatingWidget(),
      this.imageFile,
      this.viewMode = true,
      this.useCache = true,
      this.title,
      this.updateInformation,
      this.heroAnimationKey});

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    dynamic child = BaseImageViewer(
      loadingWidget: loadingWidget,
      imageUrl: imageUrl ?? '',
      placeholder: placeholder,
      useCache: useCache,
      imageFile: imageFile,
    );

// is it updateable
    if (updateInformation != null) {
      child = EditableImage(
        alwaysUpdateOnTap: !viewMode,
        updateInforamtion: updateInformation!,
        updatingWidget: updatingWidget,
        child: child,
      );
    }
// is view mode enabled
    if (viewMode) {
      child = ViewableImage(
          child: child, title: title, heroAnimationKey: heroAnimationKey);
    } else {
      child = FittedBox(
              fit: BoxFit.cover, clipBehavior: Clip.hardEdge, child: child);
    }
    return child;
  }
}

class EditableImage extends StatelessWidget {
  EditableImage(
      {super.key,
      required UpdateInforamtion updateInforamtion,
      required this.child,
      required this.updatingWidget,
      required this.alwaysUpdateOnTap})
      : cubit = ImageUpladerCubit(child.imageUrl, updateInforamtion);
  final ImageUpladerCubit cubit;
  final BaseImageViewer child;
  final Widget updatingWidget;
  final bool alwaysUpdateOnTap; // suitable if view mode is disabled

// caller should call this function to update the image
  Future<void> updateImage(BuildContext context) async {
    imagePickerHelper.call(context, (image) async {
      await cubit.uploadImage(image: image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageUpladerCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ImageUpladerCubit, ImageUpladerState>(
        bloc: cubit,
        buildWhen: (previous, current) {
          return (cubit.currentUrl != child.imageUrl) ||
              (current is ImageUpladerLoading) ||
              (current is ImageUpladerError);
        },
        builder: (context, state) {
          Widget stack = Stack(
            alignment: Alignment.center,
            children: [
              state is ImageUpladerLoaded
                  ? child.copyWithNewUrl(
                      cubit.currentUrl) // when successfully updated
                  : child, // if not updated yet
              state is ImageUpladerLoading ? updatingWidget : Container(),
            ],
          );
          if (alwaysUpdateOnTap) {
            return GestureDetector(
              onTap: () async {
                await updateImage(context);
              },
              child: stack,
            );
          }
          return stack;
        },
      ),
    );
  }
}

class BaseImageViewer extends StatelessWidget {
  /* responsible for showing image from network or file
  *  if image file is provided it will be prioritized
  *  if useCache is true it will use cached network image
  *  if useCache is false it will return regular network image
  *  it will handle loading and error states
   */
  const BaseImageViewer({
    super.key,
    required this.loadingWidget,
    required this.imageUrl,
    required this.placeholder,
    required this.useCache,
    this.imageFile,
  });

  final Widget loadingWidget;
  final String imageUrl;
  final Widget placeholder;
  final XFile? imageFile;
  final bool useCache;

  // copy with for updated values
  BaseImageViewer copyWithNewUrl(String newUrl) {
    return BaseImageViewer(
      loadingWidget: loadingWidget,
      imageUrl: newUrl,
      placeholder: placeholder,
      useCache: useCache,
    );
  }

  @override
  Widget build(BuildContext context) {
    // image file will be prioritized
    final Widget imageWidget;
    if (imageFile != null) {
      imageWidget = Image.file(
        File(imageFile!.path),
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) => placeholder,
      );
    } else if (useCache) {
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => loadingWidget,
        errorWidget: (context, url, error) => placeholder,
      );
    } else {
      imageWidget = Image.network(
        imageUrl,
        errorBuilder: (context, error, stackTrace) => placeholder,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return loadingWidget;
        },
      );
    }
    return imageWidget;
  }
}

class ViewableImage extends StatelessWidget {
  const ViewableImage(
      {super.key, required this.child, this.title, this.heroAnimationKey});

  final Widget child;
  final String? title;
  final String? heroAnimationKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          if (heroAnimationKey != null) {
            return Hero(
                tag: heroAnimationKey!,
                child: ViewModePage(
                  title: title,
                  child: child,
                ));
          }
          return ViewModePage(
            title: title,
            child: child,
          );
        }));
      },
      child: heroAnimationKey == null
          ? FittedBox(
              fit: BoxFit.cover, clipBehavior: Clip.hardEdge, child: child)
          : Hero(
              tag: heroAnimationKey!,
              child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: child)),
    );
  }
}

// UI Components
class ViewModePage extends StatelessWidget {
  /* responsible for showing image in view mode
  *  it will show the widget either [BaseImageViewer or EditableImage] with title and edit button
  *  if the child type is EditableImage it will show the edit button
  *  if the child is not EditableImage it will not show the edit button
   */
  const ViewModePage({super.key, this.title, required this.child});
  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title ?? ''),
          actions: [
            child is! EditableImage
                ? Container()
                : BlocBuilder<ImageUpladerCubit, ImageUpladerState>(
                    bloc: (child as EditableImage).cubit,
                    builder: (context, state) {
                      return IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: state is! ImageUpladerLoading
                            ? () async {
                                await (child as EditableImage)
                                    .updateImage(context);
                              }
                            : null,
                      );
                    },
                  ),
          ],
        ),
        body: InteractiveViewer(child: child));
  }
}

class DefaultPlaceHolder extends StatelessWidget {
  const DefaultPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image),
      ),
    );
  }
}

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return sceleton background grey lodaer
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.darkblue,
      ),
    );
  }
}

class DefaultUpdatingWidget extends StatelessWidget {
  const DefaultUpdatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: AppColors.darkblue,
          )),
    );
  }
}
