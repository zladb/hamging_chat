import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  TabInfo({
    required this.icon,
    required this.label,
  });
}

final TABS = [
  TabInfo(icon: Icons.people, label: '채팅',),
  TabInfo(icon: Icons.search, label: '유저 검색',),
  // TabInfo(icon: Icons.flag, label: '수거요청',),
  TabInfo(icon: Icons.account_circle, label: '마이페이지',),
];
