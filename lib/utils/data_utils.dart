import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../manager/Image_manager.dart';
import '../service/firebase_firestore_service.dart';

class DataUtils {
  static DateTime timeStampToDateTime(Timestamp value) {
    DateTime myDateTime = value.toDate();
    return myDateTime;
  }

  static Timestamp dateTimeToTimeStamp(DateTime value) {
    Timestamp myTimeStamp = Timestamp.fromDate(value);
    return myTimeStamp;
  }

  static Future<Uint8List?> getImage() async {
    Uint8List? file;
    final imageManager = ImageManager();
    file = await imageManager.getImage();
    return file;
  }

  static Future<String?> getAndSaveImage() async {
    Uint8List? file;
    String? location;
    final imageManager = ImageManager();
    file = await imageManager.getImage();

    if (file != null) {
      debugPrint('file 추가 시작');
      location = await FirebaseFirestoreService.saveUserImage(file: file);
      debugPrint('유저 이미지 저장');
      return location;
    } else {
      debugPrint('이미지가 null 입니다.');
    }
    return null;
  }
}
