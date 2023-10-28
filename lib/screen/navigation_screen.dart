
import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';
import 'package:flutter_block/screen/chats_screen.dart';
import 'package:flutter_block/screen/search_screen.dart';

import '../const/tabs.dart';

class NavigationScreen extends StatefulWidget {
  // final User? user;
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _MainPageState();
}

class _MainPageState extends State<NavigationScreen> with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: TABS.length, vsync: this);
    controller.addListener(() {
      // 컨트롤의 상태가 변경될 때 마다 rebuild
      setState(() {});
    });
  }

  List pages = [
    ChatsScreen(),
    UserSearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[controller.index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: controller.index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          controller.animateTo(index);
        },
        items: TABS
            .map(
              (e) => BottomNavigationBarItem(
            icon: Icon(
              e.icon,
            ),
            label: e.label,
          ),
        )
            .toList(),
      ),
    );
  }
}
