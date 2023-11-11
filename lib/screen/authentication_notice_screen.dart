import 'package:flutter/material.dart';
import 'package:flutter_block/screen/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../const/colors.dart';
import '../layout/default_layout.dart';

final fToast = FToast();

class AuthenticationNoticeScreen extends StatefulWidget {
  const AuthenticationNoticeScreen({super.key});

  @override
  State<AuthenticationNoticeScreen> createState() => _AuthenticationNoticeScreenState();
}

class _AuthenticationNoticeScreenState extends State<AuthenticationNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                renderHeader(),
                renderButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go('/login');
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: PRIMARY_COLOR,
        padding: const EdgeInsets.all(20),
      ),
      child: const Text('로그인 화면으로 돌아가기'),
    );
  }

  Widget renderHeader() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/img/hamging_sketchbook.png',
            width: 300,
            height: 300,
          ),
          const _Title(),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '야호! 인증 메일이 발송되었어요!\n 인증 링크를 누르고 계정을 인증해주세요 :D',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
