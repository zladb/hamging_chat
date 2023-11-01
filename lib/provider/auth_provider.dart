import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../component/toast.dart';
import '../model/user.dart';

enum UserState {
  none,
  loading,
  error,
  user,
}

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authProvider = StateNotifierProvider<AuthStateNotifier, UserBase>((ref) {
  final FirebaseAuth _firebaseAuth = ref.watch(firebaseAuthProvider);
  final notifier = AuthStateNotifier(firebaseAuth: _firebaseAuth);
  return notifier;
});

class AuthStateNotifier extends StateNotifier<UserBase> {
  final fToast = FToast();

  final FirebaseAuth firebaseAuth;
  AuthStateNotifier({required this.firebaseAuth}) : super(UserNone());

  Future<User?> signInEmailAndPassword(
      {required email, required password}) async {
    User user;
    try {
      state = UserNone();
      UserCredential _credential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (_credential.user != null) {
        user = _credential.user!;
        // 현재 유저
        state = UserLoading();

        if (user!.emailVerified) {
          // print('로그인 성공!\n id: $email, password: $password');
          // showToast(fToast: fToast, text: '로그인 성공.');
          state = UserModel(
            uid: user.uid,
            name: user.displayName ?? 'null',
            email: user.email!,
            image: 'https://pbs.twimg.com/media/F8fWq4PasAAW7Xu.jpg',
            lastActive: DateTime.now(),
            isOnline: true,
          );

          return user;
        }
      } else {
        showToast(fToast: fToast, text: '서버 에러');
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

  Future<void> putUserData() async {
    final user = state as UserModel;
    print('유저 데이터 로딩 시작');
    print(user.toJson());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.toJson());
    print('유저 데이터 로딩 완료');

  }

  Future<void> updateUserName({required String name}) async {
    final user = (state as UserModel).copyWith(name: name);
    print('유저 세부 정보 업데이트 시작');
    print(user.toJson());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.toJson());
    print('유저 세부 정보 업데이트 완료');

  }

  Future<User?> signUpWithVerifyEmailAndPassword(
      {required email, required password}) async {
    User user;
    try {
      state = UserLoading();
      UserCredential _credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _credential.user!.sendEmailVerification();
      showToast(fToast: fToast, text: '인증 메일이 발송되었습니다.');

      if (_credential.user != null) {
        user = _credential.user!;

        // TODO : 이거 맞나...???
        state = UserNone();

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

  // Future<User?> createEmailAndPassword(
//     {required email, required password}) async {
//   User user;
//   try {
//     state = UserState.loading;
//     UserCredential _credential = await firebaseAuth
//         .createUserWithEmailAndPassword(email: email, password: password);
//     if (_credential.user != null) {
//       state = UserState.user;
//       user = _credential.user!;
//       print("회원가입 성공! id: $email, password: $password");
//       return user;
//     } else {
//       // showSnackbar(context, "Server Error");
//     }
//   } on FirebaseAuthException catch (error) {
//     String? _errorCode;
//     switch (error.code) {
//       case "email-already-in-use":
//         _errorCode = error.code;
//         print(error.code);
//         break;
//       case "invalid-email":
//         _errorCode = error.code;
//         print(error.code);
//         break;
//       case "weak-password":
//         _errorCode = error.code;
//         print(error.code);
//         break;
//       case "operation-not-allowed":
//         _errorCode = error.code;
//         print(error.code);
//         break;
//       default:
//         _errorCode = null;
//     }
//     if (_errorCode != null) {
//       // showSnackbar(context, _errorCode);
//     }
//     return null;
//   }
// }
}
