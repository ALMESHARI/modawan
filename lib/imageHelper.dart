// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  void call(BuildContext context, Function(XFile file) onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () async {
                final XFile? image = await _pickImage(ImageSource.camera);
                if (image == null) return;
                onSelected(image);
                // dont use buildcontext in async gap because it may be disposed
                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () async {
                final XFile? image = await _pickImage(ImageSource.gallery);
                if (image == null) return;
                onSelected(image);
                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<XFile?> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: source);
    // check whether the platform is web or not
    if (image == null) return null;
    if (kIsWeb) {
      // it should be read as bytes
      final bytes = await image.readAsBytes();
      // convert the bytes to XFile
      image = XFile.fromData(bytes);
    }
    // the caller is responsible for handling the null value
    return image;
  }
}

ImagePickerHelper imagePickerHelper = ImagePickerHelper();
