import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/service/firebase_firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../manager/Image_manager.dart';
import 'custom_text_from_field.dart';

class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField({super.key, required this.receiverId});

  final String receiverId;

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  final controller = TextEditingController();
  Uint8List? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(fireStoreProvider.notifier);
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            isChat: true,
            controller: controller,
            onChanged: (String value) {},
            hintText: '메세지를 입력하세요...',
          ),
        ),
        const SizedBox(width: 5),
        CircleAvatar(
          backgroundColor: PRIMARY_COLOR,
          radius: 20,
          child: IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              _sendText(context);
            },
          ),
        ),
        const SizedBox(width: 5),
        CircleAvatar(
          backgroundColor: PRIMARY_COLOR,
          radius: 20,
          child: IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: () {
              _sendImage();
            },
          ),
        ),
      ],
    );
  }

  Future<void> _sendText(BuildContext context) async {
    if (controller.text.isNotEmpty) {
      await FirebaseFirestoreService.addTextMessage(
        receiverId: widget.receiverId,
        content: controller.text,
      );
      controller.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }

  Future<void> _sendImage() async {
    final imageManager = ImageManager();
    file = await imageManager.getImage();

    if (file != null) {
      print('file 추가 시작');
      await FirebaseFirestoreService.addImageMessage(
        receiverId: widget.receiverId,
        file: file!,
      );
      print('이미지 전송 완료!');
    }
    else{
      print('이미지가 null 입니다.');
    }
  }
}
