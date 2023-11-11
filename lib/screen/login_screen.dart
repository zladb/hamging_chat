import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_text_from_field.dart';
import '../component/toast.dart';
import '../main.dart';
import '../model/user.dart';
import '../provider/auth_provider.dart';
import 'edit_user_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late FToast fToast;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String username = '';
  String password = '';

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
                  renderUpper(),
                  idInput(),
                  pwInput(),
                  buttons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // }
  }

  Widget idInput() {
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

  Widget pwInput() {
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

  Widget buttons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            UserBase user;
            debugPrint('로그인 시도');
            debugPrint('username => $username\npassword => $password');
            await ref.read(authProvider.notifier).signInEmailAndPassword(
                  email: username,
                  password: password,
                );
            user = ref.read(authProvider);
            // 유저 정보가 db에 존재하면?
            if (user is UserModel) {
              showToast(fToast: fToast, text: '로그인 성공');

              if (!context.mounted) return;
                context.go('/chats');
            }
            // 로그인에는 성공했지만, 유저 정보가 db에 존재하지 않는다면?
            else if (user is UserCreating) {
              // setDefaultData -> 유저 디폴트 정보를 UserModel에 담아서 state를 업데이트하고, db에 추가한다.
              user = ref.read(authProvider.notifier).setDefaultData();
              if (!context.mounted) return;
              context.go('/my_page/edit_profile', extra: user);
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => EditUserScreen(user: user! as UserModel)));
            }
            else{

            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PRIMARY_COLOR,
            padding: const EdgeInsets.all(20),
          ),
          child: const Text('로그인'),
        ),
        const SizedBox(height: 8.0),
        TextButton(
          onPressed: () {
            context.go('/register');
          },
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
          child: const Text('회원가입'),
        ),
      ],
    );
  }

  Widget renderUpper() {
    return Column(
      children: [
        const _Title(),
        const SizedBox(height: 16.0),
        const _SubTitle(),
        Image.asset(
          'asset/img/hamging_dancing.png',
          // width: MediaQuery.of(context).size.width / 3 *2,
          width: 250,
          height: 250,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
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
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 햄깅햄깅한 하루 되세요 :D ✨',
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
