import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block/route/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: BasicApp(),
    ),
  );
}

class BasicApp extends StatelessWidget {
  // final GlobalKey<NavigatorState>? navigatorKey;
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      builder: FToastBuilder(),
      // home: const LoginScreen(),
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      // key: navigatorKey,
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
