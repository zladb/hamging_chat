
import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'base_image_manager.dart';

class ImageManagerImpl extends BaseImageManager{
  @override
  Future<Uint8List?> getImage() async {
    final Uint8List? pickedimageWeb = await ImagePickerWeb.getImageAsBytes();
    if (pickedimageWeb == null){
      debugPrint('이미지가 null 입니다. - web');
    }
    else{
      debugPrint('이미지를 성공적으로 받았습니다. - web');
    }
    return pickedimageWeb;
  }

}