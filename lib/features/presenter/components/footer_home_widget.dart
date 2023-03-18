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
                  Icons.arrow_left,
                  size: 72,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    itemCount: controller.totalNumberPages,
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

                              final isIndexSelected =
                                  controller.indexPageSelected.value == page;

                              return GestureDetector(
                                onTap: () => controller.changePage(page),
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
                                      (page + 1).toString(),
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
                      );
                    }),
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
      ),
    );
  }
}
