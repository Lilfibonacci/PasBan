import 'package:flutter/material.dart';
import 'package:flutter_authenticator/bloc/localization/localization_bloc.dart';
import 'package:flutter_authenticator/bloc/localization/localization_event.dart';
import 'package:flutter_authenticator/bloc/localization/localization_state.dart';
import 'package:flutter_authenticator/bloc/theme/theme_bloc.dart';
import 'package:flutter_authenticator/bloc/theme/theme_event.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/ui/screen/about_screen.dart';
import 'package:flutter_authenticator/ui/widget/custom_switch.dart';
import 'package:flutter_authenticator/ui/widget/drawer_tile.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  final TextTheme textTheme;
  final bool isDark;
  final AppLocalizations l10n;

  const MyDrawer({
    super.key,
    required this.textTheme,
    required this.isDark,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [MyColors.tomato, MyColors.mistyRose],
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/pasbanlogo.png"),
            ),
            accountName: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                l10n.title,
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            accountEmail: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "v 1.0.0",
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          //dark mode tile
          DrawerTile(
            trailling: Transform.scale(
              scale: 0.7,
              child: CustomSwitchWidget(
                isDarkMode: isDark,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(SwitchThemeEvent());
                },
              ),
            ),
            icon: isDark ? Icons.dark_mode_outlined : Icons.light_mode,
            iconColor: MyColors.salmon,
            title: Text(
              l10n.darkModeTle,
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
            onTap: () {},
          ),

          //work tile
          DrawerTile(
            icon: Icons.question_mark_rounded,
            iconColor: MyColors.salmon,
            title: Text(
              l10n.workTile,
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
            onTap: () {},
          ),

          //about tile
          DrawerTile(
            icon: Icons.info,
            iconColor: MyColors.salmon,
            title: Text(
              l10n.aboutUsTile,
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
            onTap: () {
              context.pushNamed(AboutScreen.routeName);
            },
          ),

          //language tile
          BlocBuilder<LocalizationBloc, LocalizationState>(
            builder: (context, state) {
              return DrawerTile(
                icon: Icons.language,
                iconColor: MyColors.salmon,
                title: Text(
                  l10n.laguage,
                  style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                ),
                onTap: () {},
                trailling: DropdownButton<String>(
                  value: state.locale.languageCode,

                  underline: const SizedBox(),

                  dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                  elevation: 6,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),

                  items: const [
                    DropdownMenuItem(
                      value: "en",
                      child: Text(
                        "English",
                        style: TextStyle(fontFamily: 'cr'),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "fa",
                      child: Text("فارسی", style: TextStyle(fontFamily: 'cr')),
                    ),
                  ],

                  onChanged: (String? newValue) {
                    if (newValue != null &&
                        newValue != state.locale.languageCode) {
                      context.read<LocalizationBloc>().add(ChangeLocaleEvent());
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
