import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/features/data/data_sources/services/services_constants.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';
import 'package:marvel_plus/features/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel_plus/features/presenter/pages/character_details_page.dart';

class HomeController extends GetxController
    with StateMixin<List<CharacterEntity>> {
  final GetCharactersUseCase getCharactersUseCase;

  HomeController({required this.getCharactersUseCase});

  var indexPageSelected = 0.obs;
  var isLoadingAllData = true.obs;
  final listPages = [0, 1, 2, 3];
  var listCharactersSearched = [].obs;
  final textSearchController = TextEditingController();

  @override
  void onInit() async {
    getCharacters();
    super.onInit();
  }

  void changePage(int index) {
    if (index != indexPageSelected.value) {
      indexPageSelected.value = index;
      change([], status: RxStatus.loading());
      getCharacters();
    }
  }

  goToNextPage() {
    if (indexPageSelected.value != listPages.length - 1) {
      indexPageSelected++;

      change([], status: RxStatus.loading());
      getCharacters();
    }
  }

  goToPreviousPage() {
    if (indexPageSelected.value != 0) {
      indexPageSelected--;

      change([], status: RxStatus.loading());
      getCharacters();
    }
  }

  Future<void> getCharacters() async {
    final requestPagination = RequestPaginationEntity(
      limit: ServicesConstants.offsetDefaultCharacters,
      offset:
          indexPageSelected.value * ServicesConstants.offsetDefaultCharacters,
    );

    final result =
        await getCharactersUseCase(requestPagination: requestPagination);

    result.fold((left) {
      change(null, status: RxStatus.error(left.message));
    }, (right) {
      change(right, status: RxStatus.success());
    });

    isLoadingAllData.value = false;
  }

  onChangedText(String text) {
    if (text.isEmpty) {
      listCharactersSearched.clear();
      refresh();
    } else {
      final mainListCharacters = value;

      final search = mainListCharacters
          ?.where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      listCharactersSearched.value = List.from(search ?? []);
      refresh();
    }
  }

  goToDetailsPage({required CharacterEntity characterEntity}) {
    Get.to(() => CharacterDetailsPage(), arguments: characterEntity);
  }

  onTapCloseButton() {
    textSearchController.clear();
    listCharactersSearched.clear();
    refresh();
  }
}
