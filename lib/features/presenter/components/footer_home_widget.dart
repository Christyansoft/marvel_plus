import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_plus/features/presenter/controllers/home_controller.dart';

class FooterHomeWidget extends StatelessWidget {
  FooterHomeWidget({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 70,
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
                                child: isIndexSelected
                                    ? CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: Text(
                                          pageToShow,
                                          style: const TextStyle(
                                              color: Colors.white,   fontSize: 18),
                                        ),
                                      )
                                    : Text(
                                        pageToShow,
                                        style: TextStyle(
                                          color: isIndexSelected
                                              ? Colors.white
                                              : Theme.of(context).primaryColor,
                                          fontSize: 16
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ),
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
