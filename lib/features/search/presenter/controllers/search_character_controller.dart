import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/core/routes/routes_config.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';

class SearchCharacterController extends GetxController {
  var listCharactersSearched = [].obs;
  List<CharacterEntity> mainListCharacters = [];
  final textSearchController = TextEditingController();

  @override
  void onInit() {
    mainListCharacters = Get.arguments;
    super.onInit();
  }

  onTapCloseButton() {
    textSearchController.clear();
    listCharactersSearched.clear();
    refresh();
  }

  onChangedText(String text) {
    if (text.isEmpty) {
      listCharactersSearched.clear();
      refresh();
    } else {
      final search = mainListCharacters
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      listCharactersSearched.value = List.from(search);
      refresh();
    }
  }

  goToDetailsPage({required CharacterEntity characterEntity}) {
    Get.toNamed(RoutesConfig.characterDetailsPage, arguments: characterEntity);
  }

  @override
  void onClose() {
    listCharactersSearched.clear();
    mainListCharacters.clear();
    super.onClose();
  }
}
