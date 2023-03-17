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
  final pageController = PageController();

  late List<int> listTotalCharacters;
  late int totalNumberPages;

  int indexPageViewSelected = 0;

  List<int> listCurrentRangePages = [];

  @override
  void onInit() async {
    listTotalCharacters = List.generate(17, (index) => index);
    totalNumberPages =
        (listTotalCharacters.length / ServicesConstants.offsetDefaultCharacters)
            .ceil();

    getCharacters();
    super.onInit();
  }

  List<int> getRangePages({required int index}) {
    int start = index * ServicesConstants.offsetDefaultCharacters;
    int end = (index + 1) * ServicesConstants.offsetDefaultCharacters;

    if (end > listTotalCharacters.length) {
      end = listTotalCharacters.length;
    }

    listCurrentRangePages = listTotalCharacters.getRange(start, end).toList();
    return listCurrentRangePages;
  }

  void changePage(int index) {
    if (index != indexPageSelected.value) {
      indexPageSelected.value = index;
      change([], status: RxStatus.loading());
      getCharacters();
    }
  }

  goToNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.ease);

    indexPageSelected.value = listCurrentRangePages.last + 1;
    change([], status: RxStatus.loading());
    getCharacters();
  }

  goToPreviousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.ease);

    indexPageSelected.value = listCurrentRangePages.first - 1;
    change([], status: RxStatus.loading());
    getCharacters();
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
