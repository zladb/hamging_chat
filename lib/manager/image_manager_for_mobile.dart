
import 'package:flutter/foundation.dart';

import '../service/media_service.dart';
import 'base_image_manager.dart';

class ImageManagerImpl extends BaseImageManager{

  @override
  Future<Uint8List?> getImage() async {
    final pickedImage = await MediaService.pickImage();
    return pickedImage;
  }
}
