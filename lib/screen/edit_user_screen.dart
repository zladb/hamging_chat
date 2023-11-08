import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';
import '../provider/auth_provider.dart';
import '../service/firebase_firestore_service.dart';
import '../utils/data_utils.dart';

class EditUserScreen extends ConsumerStatefulWidget {
  final UserModel user;
  const EditUserScreen({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends ConsumerState<EditUserScreen> {
  bool isSavable = false;
  String? imgLocation;
  Uint8List? image;

  final GlobalKey<FormState> _editProfileFormKey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController.text = widget.user.name;
    commentController.text = widget.user.comment ?? '';
    imgLocation = widget.user.image;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var user = ref.watch(firebaseAuthProvider).currentUser;
    var user = FirebaseAuth.instance.currentUser;


    return DefaultLayout(
      title: 'Edit User Profile',
      actions: [
        saveButton(user!),
      ],
      child: Form(
        key: _editProfileFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              editPhoto(),
              userNameInput(),
              const SizedBox(height: 8),
              commentInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget saveButton(User? user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: isSavable
            ? () async {
          user!.updateDisplayName(usernameController.text);
          if (image != null) {
            imgLocation = await FirebaseFirestoreService.saveUserImage(
                file: image!);
          }
          await ref.read(authProvider.notifier).updateUserInfo(
            name: usernameController.text,
            comment: commentController.text,
            image: imgLocation,
          );

          // TODO: 여기다가 깔삼한 로딩 페이지 있으면 좋겠음.
          if (!context.mounted) return;
          Navigator.of(context).pop();
        }
            : null,
        style: ButtonStyle(
          overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        child: Text(
          'SAVE',
          style: TextStyle(
            color: isSavable ? PRIMARY_COLOR : GREY,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget editPhoto() {
    return GestureDetector(
      onTap: () async {
        image = await DataUtils.getImage();
        // print(image);
        // imgLocation = await DataUtils.getAndSaveImage();
        setState(() {
          isSavable = true;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              backgroundImage: image != null
                  ? MemoryImage(image!)
                  : NetworkImage(widget.user.image) as ImageProvider,
              // NetworkImage(imgLocation!),
              backgroundColor: PRIMARY_COLOR,
              radius: 45,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 60.0,
                top: 60.0,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: GREY,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userNameInput() {
    return TextFormField(
      controller: usernameController,
      cursorColor: PRIMARY_COLOR,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: PRIMARY_COLOR,
          ),
        ),
        prefixIcon: Align(
          alignment: Alignment.centerLeft,
          // widthFactor: 2.5,
          child: Text(
            "이름",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        prefixIconConstraints:
        BoxConstraints(minWidth: 0, minHeight: 0, maxWidth: 70),
        hintText: '이름 입력',
      ),
      onChanged: (value) => setState(
              () => isSavable = _editProfileFormKey.currentState!.validate()),
      autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '이름을 입력하세요.';
        } else {
          return null;
        }
      },
    );
  }

  Widget commentInput() {
    return TextFormField(
      controller: commentController,
      maxLength: 150,
      cursorColor: PRIMARY_COLOR,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: PRIMARY_COLOR,
          ),
        ),
        prefixIcon: Align(
          alignment: Alignment.centerLeft,
          // widthFactor: 2.5,
          child: Text(
            "자기소개",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        prefixIconConstraints:
        BoxConstraints(minWidth: 0, minHeight: 0, maxWidth: 70),
        hintText: '자기소개 입력 (최대 150글자)',
      ),
      onChanged: (value) => setState(
              () => isSavable = _editProfileFormKey.currentState!.validate()),
      autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '자기소개를 입력하세요.';
        } else {
          return null;
        }
      },
    );
  }
}
