import 'package:get/get.dart';
import 'package:marvel_plus/core/http_client/http_client_impl.dart';
import 'package:marvel_plus/features/data/data_sources/character_data_source_impl.dart';
import 'package:marvel_plus/features/data/repositories/character_repository_impl.dart';
import 'package:marvel_plus/features/domain/use_cases/get_characters_use_case.dart';
import 'package:marvel_plus/features/presenter/controllers/home_controller.dart';

class DependencyManager implements Bindings {
  @override
  void dependencies() {
    Get.put(
      GetCharactersUseCase(
        characterRepository: Get.put(
          CharacterRepositoryImpl(
            characterDataSource:
                CharacterDataSourceImpl(httpClient: HttpClientImpl()),
          ),
        ),
      ),
    );
    Get.put(HomeController(getCharactersUseCase: Get.find()));
  }
}
