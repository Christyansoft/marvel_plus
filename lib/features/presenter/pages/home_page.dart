import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/features/presenter/components/character_card_widget.dart';
import 'package:marvel_plus/features/presenter/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.isLoadingAllData.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const HeaderHomeWidget(),
                    controller.obx(
                      (state) {
                        final listCharacters = state ?? [];

                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              listCharacters.length,
                              (index) {
                                final item = listCharacters[index];

                                return Column(
                                  children: [
                                    CharacterCardWidget(
                                      name: item.name,
                                      imageUrl: item
                                          .characterThumbnailEntity.imageUrl,
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

class FooterHomeWidget extends StatelessWidget {
  FooterHomeWidget({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: controller.goToPreviousPage,
              child: Icon(
                Icons.arrow_left,
                size: 72,
                color: Theme.of(context).primaryColor,
              ),
            ),
            ...List.generate(
              controller.listPages.length,
              (index) => Obx(
                () {
                  final isIndexSelected =
                      controller.indexPageSelected.value == index;

                  return GestureDetector(
                    onTap: () => controller.changePage(index),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: !isIndexSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      child: CircleAvatar(
                        radius: 19,
                        backgroundColor: isIndexSelected
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: isIndexSelected
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: controller.goToNextPage,
              child: Icon(
                Icons.arrow_right,
                size: 72,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'BUSCA MARVEL',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'TESTE FRONT-END',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Nome do Personagem',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  )),
              SizedBox(
                height: 38,
                child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 40,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
