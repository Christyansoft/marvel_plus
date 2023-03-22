import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';
import 'package:marvel_plus/features/presenter/components/character_card_widget.dart';
import 'package:marvel_plus/features/presenter/components/footer_home_widget.dart';
import 'package:marvel_plus/features/presenter/components/header_home_widget.dart';
import 'package:marvel_plus/features/presenter/controllers/home_controller.dart';

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
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderHomeWidget(
                  onChangedText: controller.onChangedText,
                  onTapCloseButton: controller.onTapCloseButton,
                  textEditingController: controller.textSearchController,
                ),
                controller.obx(
                  onLoading: Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  (state) {
                    late List<CharacterEntity> listCharacters;

                    if (controller.listCharactersSearched.isNotEmpty) {
                      listCharacters =
                          List.from(controller.listCharactersSearched);
                    } else {
                      listCharacters = state ?? [];
                    }

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
