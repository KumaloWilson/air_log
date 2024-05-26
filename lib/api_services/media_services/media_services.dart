import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaServices {
  static final ImagePicker _imagePicker = ImagePicker();


  static Future<File?> getImageFromGallery() async {
    final XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);

    if(file != null){
      return File(file.path);
    }

    return null;
  }
  static Future<List<File>?> getMultipleImagesFromGallery() async {
    final List<XFile> files = await _imagePicker.pickMultiImage();

    if (files != null) {
      return files.map((file) => File(file.path)).toList();
    }

    return null;
  }

}