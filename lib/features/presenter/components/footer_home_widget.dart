import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/features/presenter/controllers/home_controller.dart';

class FooterHomeWidget extends StatelessWidget {
  FooterHomeWidget({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      height: 50,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: controller.goToPreviousPage,
                child: Icon(
                  Icons.keyboard_arrow_left_sharp,
                  size: 36,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    itemCount: controller.itemCountPageView,
                    onPageChanged: (index) =>
                        controller.indexPageViewSelected = index,
                    itemBuilder: (context, index) {
                      final listCurrentPages =
                          controller.getRangePages(index: index);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          listCurrentPages.length,
                          (indexCurrentPage) => Obx(
                            () {
                              final page = listCurrentPages[indexCurrentPage];
                              final pageToShow = (page + 1).toString();

                              final isIndexSelected =
                                  controller.indexPageSelected.value == page;

                              return GestureDetector(
                                onTap: () => controller.changePage(page),
                                child: Text(
                                  pageToShow,
                                  style: TextStyle(
                                    color: isIndexSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: isIndexSelected ? FontWeight.bold : null
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: controller.goToNextPage,
                child: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  size: 36,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
