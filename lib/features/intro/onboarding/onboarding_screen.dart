import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_gio/components/buttons/main_button.dart';
import 'package:se7ety_gio/core/routes/navigation.dart';
import 'package:se7ety_gio/core/routes/routes.dart';
import 'package:se7ety_gio/core/services/local/shared_pref.dart';
import 'package:se7ety_gio/core/utils/colors.dart';
import 'package:se7ety_gio/core/utils/text_styles.dart';
import 'package:se7ety_gio/features/intro/onboarding/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        actions: [
          if (currentPage != 2)
            TextButton(
              onPressed: () {
                SharedPref.isOnBoardingShown(true);
                pushWithReplacement(context, Routes.welcome);
              },
              child: Text(
                'تخطي',
                style: TextStyles.body.copyWith(color: AppColors.primaryColor),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Spacer(),
                      SvgPicture.asset(onboardingList[index].image, width: 300),
                      Spacer(),
                      Gap(10),
                      Text(
                        onboardingList[index].title,
                        style: TextStyles.title,
                      ),
                      Gap(20),
                      Text(
                        onboardingList[index].description,
                        style: TextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(flex: 3),
                    ],
                  );
                },
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    onDotClicked: (index) {
                      controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    controller: controller,
                    count: onboardingList.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primaryColor,
                    ),
                  ),
                  if (currentPage == 2)
                    MainButton(
                      onPressed: () {
                        pushWithReplacement(context, Routes.welcome);
                        SharedPref.isOnBoardingShown(true);
                      },
                      text: 'هيا بنا',
                      width: 100,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
