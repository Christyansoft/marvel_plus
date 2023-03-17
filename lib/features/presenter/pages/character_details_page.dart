import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/features/presenter/controllers/home_controller.dart';

class CharacterDetailsPage extends StatelessWidget {
  CharacterDetailsPage({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(),
    );
  }
}
