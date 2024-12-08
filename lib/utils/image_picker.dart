

import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> selectImageFromGallery(ImageSource imageSource)async{
  XFile? image = await ImagePicker().pickImage(source: imageSource);
  if (image != null) {
    return image.readAsBytes();
  }
  return null;
}