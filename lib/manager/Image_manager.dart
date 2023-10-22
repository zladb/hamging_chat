import 'package:flutter/foundation.dart';
import 'image_manager_stub.dart'
  if (dart.library.io) 'image_manager_for_mobile.dart'
  if (dart.library.html) 'image_manager_for_web.dart';

class ImageManager {

  final ImageManagerImpl _ImageManager;

  ImageManager() : _ImageManager = ImageManagerImpl();

  Future<Uint8List?> getImage() async{
    return await _ImageManager.getImage();
  }

}
