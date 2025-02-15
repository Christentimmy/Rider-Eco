import 'package:get/get.dart';
import 'package:rider/controller/storage_controller.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

Future<String?> decryptOtp(String encryptedOtp) async {
  final storageController = Get.find<StorageController>();
  await storageController.saveSecretKey("ThomasTommyFuckingShelby");
  String? secretKey = await storageController.getSecretKey();
  if (secretKey == null) {
    print('No secret key found in storage.');
    return null;
  }
  final key = encrypt.Key.fromUtf8(secretKey);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  return encrypter.decrypt64(encryptedOtp, iv: iv);
}
