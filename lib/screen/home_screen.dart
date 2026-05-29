import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';

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
      drawer: const Drawer(),

      //fab
      floatingActionButton: FloatingActionButton(onPressed: () {}),

      //appBar
      appBar: AppBar(title: const Text("PasBan")),

      //body
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ItemCardWidget(index: index);
        },
      ),
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
