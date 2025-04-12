import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImageCamera() async {
  try {
    final xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickImageGallery() async {
  try {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
