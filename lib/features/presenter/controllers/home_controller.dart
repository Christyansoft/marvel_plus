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
  var listCharactersSearched = [].obs;
  final textSearchController = TextEditingController();
  final pageController = PageController();

  late List<int> listTotalCharacters;
  late int itemCountPageView;
  late int totalNumberPages;

  int indexPageViewSelected = 0;

  List<int> listCurrentRangePages = [];

  @override
  void onInit() async {
    getCharacters();
    super.onInit();
  }

  List<int> getRangePages({required int index}) {
    int start = index * ServicesConstants.totalWidgetPagePerScreen;
    int end = (index + 1) * ServicesConstants.totalWidgetPagePerScreen;

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

    if ((indexPageViewSelected + 1) != itemCountPageView) {
      indexPageSelected.value = listCurrentRangePages.last + 1;
      change([], status: RxStatus.loading());
      getCharacters();
    }
  }

  goToPreviousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.ease);

    if (indexPageViewSelected != 0) {
      indexPageSelected.value = listCurrentRangePages.first - 1;
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
      setPaginationConfig(totalCharacters: right.totalCharacters);
      change(right.listCharacters, status: RxStatus.success());
    });

    isLoadingAllData.value = false;
  }

  setPaginationConfig({required int totalCharacters}) {
    totalNumberPages =
        (totalCharacters / ServicesConstants.totalPagesByScreen).ceil();

    listTotalCharacters = List.generate(totalNumberPages, (index) => index);

    itemCountPageView =
        (totalNumberPages / ServicesConstants.totalWidgetPagePerScreen).ceil();
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
