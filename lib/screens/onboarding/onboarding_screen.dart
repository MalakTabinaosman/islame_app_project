import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_c20_dokki/models/onboarding_modal.dart';
import 'package:islami_c20_dokki/screens/home/home_screen.dart';
import 'package:islami_c20_dokki/screens/home/widgets/base_tab.dart';
import 'package:islami_c20_dokki/theme/app_colors.dart';
import 'package:islami_c20_dokki/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int itemsCount = OnboardingModel.onboardingList.length;

    return Scaffold(
      body: BaseTab(
        image: "assets/images/Rectangle.png",
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: itemsCount,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final onboardingItem =
                        OnboardingModel.onboardingList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SizedBox(
                          child: Image.asset(
                            onboardingItem.imagePath,
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          onboardingItem.title,
                          style: titleMedium(color: AppColors.gold),
                          textAlign: TextAlign.center,
                        ),
                        if (onboardingItem.description != null) ...{
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                            ),
                            child: Text(
                              onboardingItem.description!,
                              style: titleMedium(color: AppColors.gold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        },
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: _currentIndex > 0,
                      maintainAnimation: true,
                      maintainSize: true,
                      maintainState: true,

                      child: TextButton(
                        style:
                            TextButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              foregroundColor: AppColors.gold,
                            ).copyWith(
                              overlayColor: WidgetStateProperty.all(
                                Colors.transparent,
                              ),
                            ),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          "Back",
                          style: titleSmall(color: AppColors.gold),
                        ),
                      ),
                    ),

                    SmoothPageIndicator(
                      controller: _pageController,
                      count: itemsCount,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 7,
                        dotWidth: 7,
                        spacing: 6,
                        expansionFactor: 3.5,
                        activeDotColor: AppColors.gold,
                        dotColor: AppColors.white,
                      ),
                    ),
                    TextButton(
                      style:
                          TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            foregroundColor: AppColors.gold,
                          ).copyWith(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                      onPressed: () async {
                        if (_currentIndex == itemsCount - 1) {
                          final prefs = await SharedPreferences.getInstance();

                          await prefs.setBool('seenOnboarding', true);

                          Navigator.pushReplacementNamed(
                            context,
                            HomeScreen.routeName,
                          );
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      child: Text(
                        _currentIndex == itemsCount - 1 ? 'Finish' : 'Next',
                        style: titleSmall(color: AppColors.gold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
