import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modawan/core/image_picker_helper.dart';
import 'package:modawan/features/profile/repository/profile_repository.dart';
import 'package:modawan/main.dart';

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({super.key});

  @override
  State<ImageUploadPage> createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  // File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final imagePickerHelper = ImagePickerHelper();
                imagePickerHelper(context, (XFile file) async {
                  final res = await ProfileRepository().updateProfileImage(
                    userID: supabase.auth.currentUser!.id,
                    image: file,
                  );
                  res.fold(
                    (l) {
                      print(l.message);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l.message),
                          ),
                        );
                    
                    },
                    (r) {
                      print(r);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Image uploaded successfully'),
                        ),
                      );
                    },
                  );
                });
              },
              child: const Text('Pick Image'),
            ),
            // navigate replacement  button to home screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
