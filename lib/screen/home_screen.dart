import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/screen/about_screen.dart';
import 'package:flutter_authenticator/widget/custom_switch.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static String get routeName => "/HomeScreen";
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      //drawer
      drawer: MyDrawer(textTheme: textTheme),

      //fab
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add, size: 40),
      ),

      //appBar
      appBar: AppBar(title: const Text("PasBan")),

      //body
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ItemCardWidget(index: index);
        },
      ),
    );
  }
}

//Drawer
class MyDrawer extends StatelessWidget {
  final TextTheme textTheme;

  const MyDrawer({super.key, required this.textTheme});

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
              backgroundImage: AssetImage("assets/images/pasban.png"),
            ),
            accountName: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "PasBan",
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
            // trailling: CustomSwitchWidget(),
            icon: Icons.dark_mode_outlined,
            iconColor: MyColors.salmon,
            title: Text(
              "Dark Mode",
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
            onTap: () {},
          ),

          //work tile
          DrawerTile(
            icon: Icons.question_mark_rounded,
            iconColor: MyColors.salmon,
            title: Text(
              "How Its Work",
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
            onTap: () {},
          ),

          //about tile
          DrawerTile(
            icon: Icons.info,
            iconColor: MyColors.salmon,
            title: Text(
              "About Us",
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
            onTap: () {
              context.pushNamed(AboutScreen.routeName);
            },
          ),

          //language tile
          DrawerTile(
            icon: Icons.language,
            iconColor: MyColors.salmon,
            title: Text(
              "language",
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

//drawer tile
class DrawerTile extends StatelessWidget {
  final IconData icon;
  final Text title;
  final Color iconColor;
  final VoidCallback onTap;
  final Widget? trailling;

  const DrawerTile({
    this.trailling,
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: iconColor,
      titleAlignment: ListTileTitleAlignment.center,
      title: title,
      leading: Icon(icon),
      onTap: onTap,
      trailing: trailling,
    );
  }
}

//itemCard
class ItemCardWidget extends StatelessWidget {
  final int index;

  const ItemCardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final cardColor = MyColors.cardColorsList.reversed
        .toList()[index % MyColors.cardColorsList.length]
        .shade400;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Card(
        color: cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("GitHub", style: textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      Text("33658", style: textTheme.bodyLarge),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: MyColors.cardColorsList.reversed
                          .toList()[index % MyColors.cardColorsList.length]
                          .shade700,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.cardColorsList.reversed
                      .toList()[index % MyColors.cardColorsList.length]
                      .withValues(alpha: 0.3),
                ),
                onPressed: () {},
                label: const Text('Copy'),
                icon: const Icon(Icons.copy),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
