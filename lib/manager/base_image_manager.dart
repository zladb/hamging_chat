
import 'package:flutter/foundation.dart';

abstract class BaseImageManager {
  Future<Uint8List?> getImage();
}