import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/core/routes/routes_config.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';
import 'package:marvel_plus/features/home/presenter/components/character_card_widget.dart';
import 'package:marvel_plus/features/home/presenter/components/footer_home_widget.dart';
import 'package:marvel_plus/features/home/presenter/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoadingAllData.value) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        }

        return Scaffold(
          bottomNavigationBar: FooterHomeWidget(),
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: AppBar(
              title: const Text('Marvel Characters'),
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(RoutesConfig.searchCharacterPage,
                        arguments: controller.value);
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                controller.obx(
                  onLoading: Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  (state) {
                    final List<CharacterEntity> listCharacters = state ?? [];

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            listCharacters.length,
                            (index) {
                              final item = listCharacters[index];

                              return GestureDetector(
                                onTap: () => controller.goToDetailsPage(
                                  characterEntity: item,
                                ),
                                child: Hero(
                                  tag: item.id,
                                  child: Material(
                                    child: CharacterCardWidget(
                                      name: item.name,
                                      imageUrl: item
                                          .characterThumbnailEntity.imageUrl,
                                      description: item.description,
                                      hasSeries: item.series.isNotEmpty,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onError: (message) => Center(
                    child: Text(message ?? ''),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
