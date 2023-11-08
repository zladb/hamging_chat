import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  final FirebaseAuth firebaseAuth = ref.watch(firebaseAuthProvider);
  final notifier = AuthStateNotifier(firebaseAuth: firebaseAuth);
  return notifier;
});

class AuthStateNotifier extends StateNotifier<UserBase> {
  final fToast = FToast();
  late User authUser;
  FirebaseAuth firebaseAuth;

  AuthStateNotifier({required this.firebaseAuth}) : super(UserNone()) {
    // firebaseAuth = FirebaseAuth.instance;
  }

  Future<UserModel?> signInEmailAndPassword(
      {required email, required password}) async {
    try {
      UserModel? user;
      state = UserNone();
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      String myUid = FirebaseAuth.instance.currentUser!.uid;
      debugPrint('login시 지금 uid 는? $myUid');
      if (credential.user != null) {
        authUser = credential.user!;
        // 현재 유저
        state = UserLoading();

        if (authUser.emailVerified) {
          user = await getUserById(userId: authUser.uid);
          debugPrint('로그인 함수내 타입 -> ${state.runtimeType}');

          return user;
        }
      } else {
        showToast(fToast: fToast, text: '서버 에러');
      }
    } on FirebaseAuthException catch (error) {
      String? _errorCode;
      debugPrint(error.code);
      switch (error.code) {
        case "invalid-email":
          showToast(fToast: fToast, text: '유효하지 않은 메일입니다.');
          _errorCode = error.code;
          break;
        case "user-disabled":
          showToast(fToast: fToast, text: '정지된 계정입니다.');
          debugPrint('정지된 계정입니다.');
          _errorCode = error.code;
          break;
        case "invalid-login-credentials":
          showToast(fToast: fToast, text: '올바른 계정과 비밀번호인지 확인하세요.');
          debugPrint("올바른 계정과 비밀번호인지 확인하세요.");
          _errorCode = error.code;
        case "too-many-requests":
          showToast(fToast: fToast, text: '너무 많은 요청입니다. 나중에 다시 시도하세요.');
          debugPrint('너무 많은 요청이 들어왔습니다.');
          _errorCode = error.code;
        case "Unexpected null value":
          debugPrint('예상 못한 null 값입니다.');
        default:
          _errorCode = null;
      }
      if (_errorCode != null) {
        debugPrint(_errorCode);
      }
      return null;
    }
    return null;
  }

  Future<UserModel?> getUserById({required String userId}) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    UserModel? userData;
    await firebaseFirestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot user) {
      if (!user.exists) {
        state = UserNone();
        return;
      } else {
        userData =
            UserModel.fromJson(user.data()! as Map<String, dynamic>).copyWith(
          lastActive: authUser.metadata.lastSignInTime,
        );
        state = userData as UserModel;
        putUserData(); // lastSignInTime 업데이트
        debugPrint('유저 정보 불러 왔을 때 state 타입 -> ${state.runtimeType}');
        // print('state -> ${state}');
      }
    });
    debugPrint('마지막 return 타입-> ${state.runtimeType}');
    return userData;
  }

  UserModel setDefaultData() {
    UserModel userData;
    // 회원가입 후 첫 로그인의 경우 기본 더미 데이터를 넣어줌.
    const String img =
        'https://firebasestorage.googleapis.com/v0/b/hamging-dd902.appspot.com/o/image%2Fdefault%2Fhamging_basic.jpg?alt=media&token=53cc6dfb-83af-40e5-ba14-ab6a9ba0c4c0&_gl=1*j0uc3*_ga*MTY2NzA4NzM1MS4xNjk3MTAzNTA0*_ga_CW55HF8NVT*MTY5OTM1OTkzMy42My4xLjE2OTkzNTk5MzkuNTQuMC4w';
    userData = UserModel(
      uid: authUser.uid,
      name: '',
      email: authUser.email as String,
      image: img,
      lastActive: authUser.metadata.lastSignInTime!,
    );
    state = userData;
    putUserData(); // lastSignInTime 업데이트
    return userData;
  }

  Future<void> putUserData() async {
    if (state is UserLoading) {
      return;
    }
    final user = state as UserModel;
    debugPrint('유저 데이터 로딩 시작');
    debugPrint(user.toJson().toString());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.toJson());
    debugPrint('유저 데이터 로딩 완료');
  }

  Future<void> updateUserInfo(
      {String? name, String? image, String? comment}) async {
    final user = (state as UserModel)
        .copyWith(name: name, image: image, comment: comment);
    debugPrint('유저 세부 정보 업데이트 시작');
    debugPrint(user.toJson().toString());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.toJson());
    debugPrint('유저 세부 정보 업데이트 완료');

    state = user;
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

        debugPrint("회원가입\nid: $email, password: $password");
        return user;
      } else {
        debugPrint("이미 가입된 회원입니다.");
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
    return null;
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
