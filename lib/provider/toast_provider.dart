
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final toastProvider = StateProvider<FToast>((ref){
  final fToast = FToast();
  return fToast;
});