import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      return File(pickedImage.path);
    }

    return null;
  } catch (error) {
    log('Error picking image: $error');
    return null;
  }
}
