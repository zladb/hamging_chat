import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_block/provider/toast_provider.dart';
import 'package:flutter_block/screen/HomeScreen.dart';
import 'package:flutter_block/user/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../component/custom_text_from_field.dart';
import '../component/toast.dart';
import '../main.dart';
import '../provider/auth_provider.dart';
import 'RegisterScreen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String username = '';
  String password = '';
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
    username = emailController.text;
    password = passwordController.text;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    // if (state == null) {
    //   return DefaultLayout(
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //       // child: Text('로딩중'),
    //     ),
    //   );
    // }

    return DefaultLayout(
      title: '로그인',
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              // height: MediaQuery.of(context).size.height - kToolbarHeight*2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Upper(),
                  email_input(),
                  password_input(),
                  buttons(state),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget email_input() {
    return Column(
      children: [
        CustomTextFormField(
          controller: emailController,
          hintText: '이메일을 입력해주세요',
          onChanged: (String value) {
            username = value;
          },
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  Widget password_input() {
    return Column(
      children: [
        CustomTextFormField(
          controller: passwordController,
          hintText: '비밀번호를 입력해주세요',
          onChanged: (String value) {
            password = value;
          },
          obscureText: true,
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  Widget buttons(state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            User? user;
            print('로그인 시도');
            print('username => $username\npassword => $password');
            user = await ref.read(authProvider.notifier).signInEmailAndPassword(
                  email: username,
                  password: password,
                );
            // user = await signInEmailAndPassword(
            //     email: username, password: password);
            print(user);
            print(fToast.context);

            if (state == UserState.loading) {
              CircularProgressIndicator();
            }

            if (user != null) {
              showToast(fToast: fToast, text: '로그인 성공');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
          },
          child: Text('로그인'),
          style: ElevatedButton.styleFrom(
            backgroundColor: PRIMARY_COLOR,
            padding: const EdgeInsets.all(20),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
            //   print('id: $username');
            //   print('password: $password');
            //   createEmailAndPassword(email: username, password: password);
          },
          child: Text('회원가입'),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent),
            foregroundColor: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return PRIMARY_COLOR;
                }
                return Colors.grey;
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _Upper extends StatelessWidget {
  const _Upper({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Title(),
        const SizedBox(
          height: 16.0,
        ),
        _SubTitle(),
        Image.asset(
          'asset/img/hamging_dancing.png',
          // width: MediaQuery.of(context).size.width / 3 *2,
          width: 300,
          height: 300,
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 햄깅햄깅한 하루 되세요 :D ✨',
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
