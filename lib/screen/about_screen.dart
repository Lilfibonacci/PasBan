import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/core/util/url_launcher.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static String get routeName => "/AboutScreen";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      // appBar
      appBar: AppBar(
        title: Text(l10n.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      // body
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 40)),

          // logo
          SliverToBoxAdapter(
            child: Transform.scale(
              scale: 0.7,
              child: const CircleAvatar(
                radius: 95,
                backgroundImage: AssetImage("assets/images/pasban.png"),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          // description
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                l10n.describtion,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),

          // social box
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: const BoxDecoration(
                  color: MyColors.mistyRose,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //github tile
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.github,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      title: Text(
                        l10n.sourceTile,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDark ? MyColors.white : MyColors.black,
                        ),
                      ),
                      trailing: FaIcon(
                        FontAwesomeIcons.arrowUpRightFromSquare,
                        size: 18,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      onTap: () {
                        urlLauncher("https://github.com/Lilfibonacci/PasBan");
                      },
                    ),
                    const Divider(
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.black26,
                    ),

                    //email tile
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      title: Text(
                        l10n.emailTile,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDark ? MyColors.white : MyColors.black,
                        ),
                      ),
                      trailing: FaIcon(
                        FontAwesomeIcons.arrowUpRightFromSquare,
                        size: 18,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      onTap: () {
                        urlLauncher("mailto:lilfibonacci1@gmail.com");
                      },
                    ),
                    const Divider(
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.black26,
                    ),

                    //telegram tile
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.telegram,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      title: Text(
                        l10n.telegramTile,
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDark ? MyColors.white : MyColors.black,
                        ),
                      ),
                      trailing: FaIcon(
                        FontAwesomeIcons.arrowUpRightFromSquare,
                        size: 18,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      onTap: () {
                        urlLauncher("https://t.me/Lilfibonacci");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Designed with ❤️ by LilFibonacci",
                  style: textTheme.bodyMedium?.copyWith(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
