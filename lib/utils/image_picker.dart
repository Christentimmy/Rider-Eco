import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Future<Uint8List?> selectImageFromGallery(ImageSource imageSource)async{
//   XFile? image = await ImagePicker().pickImage(source: imageSource);
//   if (image != null) {
//     return image.readAsBytes();
//   }
//   return null;
// }

Future<File?> pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}