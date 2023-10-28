

import 'package:cloud_firestore/cloud_firestore.dart';

class DataUtils {
  static DateTime timeStampToDateTime(Timestamp value){
    DateTime myDateTime = value.toDate();
    return myDateTime;
  }

  static Timestamp dateTimeToTimeStamp(DateTime value){
    Timestamp myTimeStamp = Timestamp.fromDate(value);
    return myTimeStamp;
  }
}