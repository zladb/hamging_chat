import 'package:flutter/foundation.dart';
import 'package:flutter_block/manager/base_image_manager.dart';

class ImageManagerImpl extends BaseImageManager {
  @override
  Future<Uint8List?> getImage() {
    throw UnsupportedError('Cannot create an auth manager');
  }
}
