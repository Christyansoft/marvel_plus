import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/core/manager/dependency_manager.dart';
import 'package:marvel_plus/features/presenter/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffD42026),
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
          binding: DependencyManager(),
        )
      ],
    );
  }
}
