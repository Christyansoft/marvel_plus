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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(
          () => controller.isLoadingAllData.value
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderHomeWidget(
                      onChangedText: controller.onChangedText,
                      onTapCloseButton: controller.onTapCloseButton,
                      textEditingController: controller.textSearchController,
                    ),
                    controller.obx(
                      onLoading: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )),
                      ),
                      (state) {
                        late List<CharacterEntity> listCharacters;

                        if (controller.listCharactersSearched.isNotEmpty) {
                          listCharacters =
                              List.from(controller.listCharactersSearched);
                        } else {
                          listCharacters = state ?? [];
                        }

                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              listCharacters.length,
                              (index) {
                                final item = listCharacters[index];

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => controller.goToDetailsPage(
                                        characterEntity: item,
                                      ),
                                      child: Hero(
                                        tag: item.id,
                                        child: Material(
                                          child: CharacterCardWidget(
                                            name: item.name,
                                            imageUrl: item
                                                .characterThumbnailEntity
                                                .imageUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 0.7,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                      onError: (message) => Center(
                        child: Text(message ?? ''),
                      ),
                    ),
                    FooterHomeWidget()
                  ],
                ),
        ),
      ),
    );
  }
}
