import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/features/domain/entities/character_entity.dart';
import 'package:marvel_plus/features/home/presenter/components/character_card_widget.dart';
import 'package:marvel_plus/features/search/presenter/controllers/search_character_controller.dart';

class SearchCharacterPage extends GetView<SearchCharacterController> {
  const SearchCharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SizedBox(
            height: 40,
            child: Center(
              child: TextFormField(
                onChanged: controller.onChangedText,
                controller: controller.textSearchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  enabled: true,
                  suffixIcon: IconButton(
                    onPressed: controller.onTapCloseButton,
                    splashRadius: 18,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            late List<CharacterEntity> listCharacters;

            if (controller.listCharactersSearched.isNotEmpty) {
              listCharacters = List.from(controller.listCharactersSearched);
            } else {
              listCharacters = controller.mainListCharacters;
            }

            return Column(
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
                          imageUrl: item.characterThumbnailEntity.imageUrl,
                          description: item.description,
                          hasSeries: item.series.isNotEmpty,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
