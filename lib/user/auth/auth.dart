
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../component/toast.dart';
import '../../provider/toast_provider.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final fToast = FToast();

Future<User?> createEmailAndPassword(
    {required email, required password}) async {
  User user;
  try {
    UserCredential _credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    if (_credential.user != null) {
      user = _credential.user!;
      // print("회원가입 성공! id: $email, password: $password");
      return user;
    } else {
      // showSnackbar(context, "Server Error");
    }
  } on FirebaseAuthException catch (error) {
    // logger.e(error.code);
    String? _errorCode;
    switch (error.code) {
      case "email-already-in-use":
        _errorCode = error.code;
        print(error.code);
        break;
      case "invalid-email":
        _errorCode = error.code;
        print(error.code);
        break;
      case "weak-password":
        _errorCode = error.code;
        print(error.code);
        break;
      case "operation-not-allowed":
        _errorCode = error.code;
        print(error.code);
        break;
      default:
        _errorCode = null;
    }
    if (_errorCode != null) {
      // showSnackbar(context, _errorCode);
    }
    return null;
  }
}

Future<User?> signInEmailAndPassword(
    {required email, required password}) async {
  User user;
  try {
    UserCredential _credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    // await user!.reload();
    // user = _auth.currentUser;

    if (_credential.user != null) {
      user = _credential.user!;
      if (user!.emailVerified) {
        print('로그인 성공!\n id: $email, password: $password');
        // showToast(fToast: fToast, text: '로그인 성공.');
        return user;
      }
    } else {
      // showSnackbar(context, "Server Error");
    }
  } on FirebaseAuthException catch (error) {
    String? _errorCode;
    print(error.code);
    switch (error.code) {
      case "invalid-email":
        showToast(fToast: fToast, text: '유효하지 않은 메일입니다.');
        _errorCode = error.code;
        break;
      case "user-disabled":
        showToast(fToast: fToast, text: '정지된 계정입니다.');
        print('정지된 계정입니다.');
        _errorCode = error.code;
        break;
      // 아래의 케이스들은 보안상의 이유로 invalid-login-credentials로 통합됨
      // case "user-not-found":
      //   showToast(fToast: fToast, text: '존재하지 않는 계정입니다.');
      //   print('존재하지 않는 계정입니다.');
      //   _errorCode = error.code;
      //   break;
      // case "wrong-password":
      //   // showToast(fToast: fToast, text: '비밀번호가 틀렸습니다.');
      //   print('비밀번호가 틀렸습니다.');
      //   _errorCode = error.code;
      //   break;
      case "invalid-login-credentials":
        showToast(fToast: fToast, text: '올바른 계정과 비밀번호인지 확인하세요.');
        print("올바른 계정과 비밀번호인지 확인하세요.");
        _errorCode = error.code;
      case "too-many-requests":
        showToast(fToast: fToast, text: '너무 많은 요청입니다. 나중에 다시 시도하세요.');
        print('너무 많은 요청이 들어왔습니다.');
        _errorCode = error.code;
      case "Unexpected null value":
        print('예상 못한 null 값입니다.');
      default:
        _errorCode = null;
    }
    if (_errorCode != null) {
      print(_errorCode);
    }
    return null;
  }
}

Future<User?> signUpWithVerifyEmailAndPassword(BuildContext context,
    {required email, required password}) async {
  try {
    User user;
    UserCredential _credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await _credential.user!.sendEmailVerification();
    showToast(fToast: fToast, text: '인증 메일이 발송되었습니다.');

    if (_credential.user != null) {
      user = _credential.user!;
      print("회원가입\nid: $email, password: $password");
      return user;
    } else {
      print("이미 가입된 회원입니다.");
      return null;
    }
  } on FirebaseAuthException catch (error) {
    String? _errorCode;
    switch (error.code) {
      case "email-already-in-use":
        showToast(fToast: fToast, text: '이미 가입된 회원입니다.');
        _errorCode = error.code;
        break;
      case "invalid-email":
        _errorCode = error.code;
        break;
      case "weak-password":
        _errorCode = error.code;
        break;
      case "operation-not-allowed":
        _errorCode = error.code;
        break;
      default:
        _errorCode = null;
    }
  }
}

void showSnackbar(context, String errorCode) {
  const snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
