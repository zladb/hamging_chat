import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget basic_toast({required text}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: INPUT_BG_COLOR,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text(text),
      ],
    ),
  );
}

void showToast({required FToast fToast, required text}) {
  return fToast.showToast(
    child: basic_toast(text: text),
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
