import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/core/components/image_helper/cubit/image_uplader_cubit.dart';
import 'package:modawan/core/components/image_helper/image_picker_helper.dart';

import '../../../main.dart';

class DistinationInformation {
  final String distpath;
  final String bucketName;

  DistinationInformation(this.distpath, this.bucketName);
}

class ImageViewer extends StatelessWidget {
  final Widget? placeholder;
  final Widget? errorWidget;
  final Widget? progressIndicator;
  final bool checkCache;
  final String imageUrl;
  final XFile? imageFile;
  final bool viewMode;
  final String? title;
  final Function(String)? onUpdated;
  final DistinationInformation? distinationInformation; // for image update

  factory ImageViewer.network(
      {String? imageUrl,
      DistinationInformation? dist,
      Widget? placeholder,
      bool checkCache = true,
      bool viewMode = false,
      Function(String)? onUpdated,
      String? title}) {
    return ImageViewer._(
        distinationInformation: dist,
        onUpdated: onUpdated,
        imageUrl: imageUrl ?? '',
        placeholder: placeholder,
        checkCache: checkCache,
        viewMode: viewMode,
        title: title);
  }

  const ImageViewer._(
      {this.placeholder,
      this.checkCache = true,
      this.imageUrl = '',
      this.imageFile,
      this.viewMode = false,
      this.title,
      this.errorWidget,
      this.progressIndicator,
      this.distinationInformation,
      this.onUpdated});

  @override
  Widget build(BuildContext context) {
    ImageUpladerCubit? imageUpladerCubit;

    if (distinationInformation != null) {
      imageUpladerCubit = ImageUpladerCubit(distinationInformation!.bucketName,
          distinationInformation!.distpath, imageUrl, onUpdated);

      if (!viewMode) {
        return BlocBuilder<ImageUpladerCubit, ImageUpladerState>(
          bloc: imageUpladerCubit,
          builder: (context, state) {
            return Stack(children: [
              BaseImageViewer(
                placeholder: placeholder,
                progressIndicator: progressIndicator,
                imageUrl: imageUpladerCubit!.currentUrl,
                errorWidget: errorWidget,
                checkCache: checkCache,
                imageUpladerCubit: imageUpladerCubit,
              ),
              state is ImageUpladerLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(),
            ]);
          },
        );
      }
    }

    if (viewMode) {
      return withViewMode(
          context,
          title,
          BaseImageViewer(
            placeholder: placeholder,
            progressIndicator: progressIndicator,
            imageUrl: imageUrl,
            errorWidget: errorWidget,
            checkCache: checkCache,
            imageUpladerCubit: imageUpladerCubit,
          ),
          imageUpladerCubit);
    } else {
      return BaseImageViewer(
        placeholder: placeholder,
        progressIndicator: progressIndicator,
        imageUrl: imageUrl,
        errorWidget: errorWidget,
        checkCache: checkCache,
      );
    }
  }

  Widget withViewMode(BuildContext context, String? title, Widget child,
      ImageUpladerCubit? imageUpladerCubit) {
    //TODO: implement view mode

    if (imageUpladerCubit != null) {
      return BlocBuilder<ImageUpladerCubit, ImageUpladerState>(
        bloc: imageUpladerCubit,
        builder: (context, state) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewModePage(
                          title: title,
                          imageUpladerCubit: imageUpladerCubit,
                          child: child,
                        )));
              },
              child: child);
        },
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewModePage(
                    title: title,
                    child: child,
                  )));
        },
        child: child,
      );
    }
  }
}

class BaseImageViewer extends StatelessWidget {
  BaseImageViewer({
    super.key,
    required this.placeholder,
    this.progressIndicator,
    required this.imageUrl,
    this.errorWidget,
    required this.checkCache,
    this.imageUpladerCubit,
  });

  final Widget? placeholder;
  final Widget? progressIndicator;
  late String imageUrl;
  final Widget? errorWidget;
  final bool checkCache;
  final ImageUpladerCubit? imageUpladerCubit;

  @override
  Widget build(BuildContext context) {
    if (imageUpladerCubit == null) {
      return widget(context, imageUrl);
    } else {
      return BlocBuilder<ImageUpladerCubit, ImageUpladerState>(
        bloc: imageUpladerCubit,
        builder: (context, state) {
          if (state is ImageUpladerLoaded) {
            return widget(context, imageUpladerCubit!.currentUrl);
          } else if (state is ImageUpladerLoading) {
            print('loading');
            return Stack(
              children: [
                const Center(child: CircularProgressIndicator()),
                // widget(context, imageUrl),
              ],
            );
          } else if (state is ImageUpladerError) {
            //show error
            SchedulerBinding.instance!.addPostFrameCallback((timeStamp) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message))));
            
            return widget(context, imageUrl);
          } else {
            return widget(context, imageUpladerCubit!.currentUrl);
          }
        },
      );
    }
  }
  //TODO: make sure if url is empty, it should show placeholder

  CachedNetworkImage widget(BuildContext context, String? imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      placeholder: (context, url) =>
          placeholder ?? Container(color: Colors.grey[200]),
      errorWidget: (context, url, error) =>
          errorWidget ?? const Icon(Icons.error),
    );
  }
}

class ViewModePage extends StatelessWidget {
  const ViewModePage(
      {super.key, this.title, required this.child, this.imageUpladerCubit});
  final String? title;
  final Widget child;
  final ImageUpladerCubit? imageUpladerCubit;
  // if it is editable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title ?? ''),
          actions: [
            imageUpladerCubit == null
                ? Container()
                : BlocBuilder<ImageUpladerCubit, ImageUpladerState>(
                    bloc: imageUpladerCubit,
                    builder: (context, state) {
                      return IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: state is! ImageUpladerLoading
                            ? () async {
                                imagePickerHelper.call(context, (image) async {
                                  await imageUpladerCubit!
                                      .uploadImage(image: image);
                                });
                              }
                            : null,
                      );
                    },
                  ),
          ],
        ),
        body: child);
  }
}
