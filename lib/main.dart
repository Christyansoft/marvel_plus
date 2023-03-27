import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/core/routes/routes_config.dart';
import 'package:marvel_plus/features/home/manager/home_bindings.dart';
import 'package:marvel_plus/features/home/presenter/pages/character_details_page.dart';
import 'package:marvel_plus/features/home/presenter/pages/home_page.dart';
import 'package:marvel_plus/features/search/manager/search_bindings.dart';
import 'package:marvel_plus/features/search/presenter/pages/search_character_page.dart';

void main() {
  runApp(const MyApp());
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
          binding: HomeBindings(),
        ),
        GetPage(
          name: RoutesConfig.characterDetailsPage,
          page: () => CharacterDetailsPage(),
        ),
        GetPage(
          name: RoutesConfig.searchCharacterPage,
          page: () => const SearchCharacterPage(),
          binding: SearchBindings()
        )
      ],
    );
  }
}
