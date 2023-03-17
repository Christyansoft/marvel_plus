import 'package:get/get.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';
import 'package:marvel_plus/features/domain/entities/request_pagination_entity.dart';
import 'package:marvel_plus/features/domain/use_cases/get_characters_use_case.dart';

class HomeController extends GetxController
    with StateMixin<List<CharacterEntity>> {
  final GetCharactersUseCase getCharactersUseCase;

  HomeController({required this.getCharactersUseCase});

  var indexPageSelected = 0.obs;
  var isLoadingAllData = true.obs;
  final listPages = [0,1,2,3];

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
    if (indexPageSelected.value != listPages.length -1) {
      indexPageSelected++;

      change([], status: RxStatus.loading());
      getCharacters();
    }
  }

  goToPreviousPage(){
    if (indexPageSelected.value != 0) {
      indexPageSelected--;

      change([], status: RxStatus.loading());
      getCharacters();
    }
  }

  Future<void> getCharacters() async {
    final requestPagination =
        RequestPaginationEntity(limit: 4, offset: indexPageSelected.value * 4);

    final result =
        await getCharactersUseCase(requestPagination: requestPagination);

    result.fold((left) {
      change(null,
          status: RxStatus.error('Não foi possível exibir os personagens'));
    }, (right) {
      change(right, status: RxStatus.success());
    });

    isLoadingAllData.value = false;
  }
}
