import 'package:get/get.dart';
import 'package:marvel_plus/core/http_client/http_client_impl.dart';
import 'package:marvel_plus/features/data/data_sources/character_data_source_impl.dart';
import 'package:marvel_plus/features/data/repositories/character_repository_impl.dart';
import 'package:marvel_plus/features/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel_plus/features/presenter/controllers/home_controller.dart';

class DependencyManager implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HttpClientImpl());
    Get.lazyPut(
        () => CharacterDataSourceImpl(httpClient: Get.find<HttpClientImpl>()));
    Get.lazyPut(() => CharacterRepositoryImpl(
        characterDataSource: Get.find<CharacterDataSourceImpl>()));
    Get.lazyPut(() => GetCharactersUseCase(
        characterRepository: Get.find<CharacterRepositoryImpl>()));
    Get.lazyPut(() => HomeController(getCharactersUseCase: Get.find()));
  }
}
