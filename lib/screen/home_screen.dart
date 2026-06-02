import 'package:flutter/material.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/screen/scanner_screen.dart';
import 'package:flutter_authenticator/widget/custom_drawer.dart';
import 'package:flutter_authenticator/widget/item_card.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      //drawer
      drawer: MyDrawer(textTheme: textTheme, isDark: isDark, l10n: l10n),

      //fab
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () async {
          final result = await context.pushNamed(ScannerScreen.routeName);

          if (result != null) {
            debugPrint("لینک اسکن شده این است: $result");
          }
        },
        icon: const Icon(Icons.qr_code_scanner_rounded, size: 24),
        label: Text(
          "Scan QR",
          style: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      //appBar
      appBar: AppBar(title: Text(l10n.title)),

      // body
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 100, top: 8),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ItemCardWidget(index: index, l10n: l10n);
        },
      ),
    );
  }
}
