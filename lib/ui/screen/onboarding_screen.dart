import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/model/onboarding_item.dart';
import 'package:flutter_authenticator/ui/screen/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static String get routeName => "/onboardingScreen";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme!;

    final List<OnboardingItem> slides = [
      OnboardingItem(
        icon: FontAwesomeIcons.userLock,
        title: l10n.obSecurityTitle, // 👈 استفاده از کلید arb
        description: l10n.obSecurityDesc,
      ),
      OnboardingItem(
        icon: FontAwesomeIcons.powerOff,
        title: l10n.obOfflineTitle,
        description: l10n.obOfflineDesc,
      ),
      OnboardingItem(
        icon: FontAwesomeIcons.fingerprint,
        title: l10n.obBiometricTitle,
        description: l10n.obBiometricDesc,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final item = slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //icon
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: MyColors.salmon.withValues(
                              alpha: isDarkMode ? 0.15 : 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: FaIcon(
                              item.icon,
                              size: 52,
                              color: MyColors.salmon,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        //title
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 16),

                        //description
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 32.0,
                top: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //elevated button
                  SizedBox(
                    width: 140,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentIndex == slides.length - 1) {
                          context.goNamed(HomeScreen.routeName);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.salmon,
                        foregroundColor: Colors.white,
                        fixedSize: const Size(140, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _currentIndex == slides.length - 1
                            ? l10n.getStarted
                            : l10n.next,
                        style: textTheme.bodyMedium?.copyWith(fontSize: 15),
                      ),
                    ),
                  ),

                  //page indicator
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        margin: const EdgeInsets.only(left: 6),
                        height: 8,
                        width: _currentIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? MyColors.salmon
                              : (isDarkMode
                                    ? Colors.white24
                                    : Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
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
