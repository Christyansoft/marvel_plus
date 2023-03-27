import 'package:get/get.dart';
import 'package:marvel_plus/features/search/presenter/controllers/search_character_controller.dart';

class SearchBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchCharacterController());
  }
}
