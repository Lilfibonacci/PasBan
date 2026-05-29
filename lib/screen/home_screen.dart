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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(onPressed: () {}),

      //appBar
      appBar: myAppBar(),

      //body
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return itemCard(textTheme);
        },
      ),
    );
  }

  //itemCard
  Widget itemCard(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  //Totp code
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text("GitHub", style: textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      Text("33658", style: textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),

                  //progress Indicator
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: MyColors.tomato,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

            //copy Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
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

  //appBar
  PreferredSizeWidget myAppBar() {
    return AppBar(
      title: const Text("PasBan"),
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
    );
  }
}
