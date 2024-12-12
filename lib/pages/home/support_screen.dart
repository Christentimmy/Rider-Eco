import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/pages/home/home_screen.dart';
import 'package:rider/resources/colors.dart';
import 'package:rider/widgets/custom_textfield.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});

  final RxInt _currentPage = 0.obs;
  final _pageController = PageController(initialPage: 0);

  final _fagList = ["General", "Account", "Service", "Payment"];
  final _faqSelectedCard = (-1).obs;
  final _faqSearchController = TextEditingController();
  final RxBool _isFaqCardExpand = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildSideBar(),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      onTap: () {
                        _currentPage.value = 0;
                        _pageController.jumpToPage(0);
                      },
                      child: Column(
                        children: [
                          Text(
                            "FAQ",
                            style: TextStyle(
                              fontSize: 16,
                              color: _currentPage.value == 0
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 2,
                            color: _currentPage.value == 0
                                ? AppColors.primaryColor
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      onTap: () {
                        _currentPage.value = 1;
                        _pageController.jumpToPage(1);
                      },
                      child: Column(
                        children: [
                          Text(
                            "Contact Us",
                            style: TextStyle(
                              fontSize: 16,
                              color: _currentPage.value == 1
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 3,
                            color: _currentPage.value == 1
                                ? AppColors.primaryColor
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 35,
                          width: Get.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _fagList.length,
                            itemBuilder: (context, index) {
                              return Obx(
                                () {
                                  return InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      _faqSelectedCard.value = index;
                                    },
                                    child: Container(
                                      height: 4350,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(right: 10),
                                      constraints: const BoxConstraints(
                                        minWidth: 80,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _faqSelectedCard.value == index
                                            ? AppColors.primaryColor
                                            : null,
                                        borderRadius: BorderRadius.circular(20),
                                        border: _faqSelectedCard.value == index
                                            ? null
                                            : Border.all(
                                                width: 1,
                                                color: AppColors.primaryColor,
                                              ),
                                      ),
                                      child: Text(
                                        _fagList[index],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _faqSelectedCard.value == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          bgColor: const Color(0xffF5F5F5),
                          hintText: "Search",
                          textController: _faqSearchController,
                          prefixIcon: Icons.search_rounded,
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: Get.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "What is EcoExpress?",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  Obx(
                                    () => IconButton(
                                      onPressed: () {
                                        _isFaqCardExpand.value =
                                            !_isFaqCardExpand.value;
                                      },
                                      icon: Icon(
                                        _isFaqCardExpand.value
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons.keyboard_arrow_down_rounded,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Obx(
                                () => _isFaqCardExpand.value
                                    ? const Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras scelerisque leo non dignissim blandit",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        const FaqCard(text: "How do I pay for appointments"),
                        const FaqCard(text: "How to add reviews?"),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    height: 37,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Support",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
          );
        },
      ),
    );
  }
}

class FaqCard extends StatelessWidget {
  final String text;
  const FaqCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: Get.width,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
