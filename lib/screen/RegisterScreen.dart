import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_block/screen/LoginScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../component/custom_text_from_field.dart';
import '../component/toast.dart';
import '../const/colors.dart';
import '../main.dart';
import '../provider/auth_provider.dart';
import '../user/auth/auth.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String username = '';
  String password = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '회원가입',
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SizedBox(
                // height: MediaQuery.of(context).size.height - kToolbarHeight*2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Upper(),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이메일을 입력해주세요.';
                        } else if (EmailValidator.validate(value) == false) {
                          return '올바른 형식의 이메일을 입력해주세요.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      hintText: '이메일을 입력해주세요',
                      onChanged: (String value) {
                        username = value;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '비밀번호를 입력해주세요.';
                        } else if (value.length < 6) {
                          return '6자리 이상의 비밀번호를 입력해주세요.';
                        }
                        return null;
                      },
                      hintText: '비밀번호를 입력해주세요',
                      onChanged: (String value) {
                        password = value;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? user;
                          print('회원가입 시도');
                          user = await ref
                              .read(authProvider.notifier)
                              .signUpWithVerifyEmailAndPassword(
                                email: username,
                                password: password,
                              );
                          // user = await signUpWithVerifyEmailAndPassword(context,
                          //     email: username, password: password);
                          print(user);

                          if (user != null)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                        }
                      },
                      child: Text('회원가입 하기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                        padding: const EdgeInsets.all(20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Upper extends StatelessWidget {
  const _Upper({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Message(),
        const SizedBox(height: 16.0),
        // _SubTitle(),
        Image.asset(
          'asset/img/hamging_ddabong.png',
          // width: MediaQuery.of(context).size.width / 3 *2,
          width: 300,
          height: 300,
        ),
      ],
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '유진이의 비밀 친구가 되어주세요.\n바로 이메일 인증하기!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
