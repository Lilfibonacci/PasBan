import 'package:flutter/material.dart';
import 'package:flutter_authenticator/bloc/account/account_bloc.dart';
import 'package:flutter_authenticator/bloc/account/account_event.dart';
import 'package:flutter_authenticator/bloc/account/account_state.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/core/util/otp_parser.dart';
import 'package:flutter_authenticator/core/util/secure_storage_services.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/screen/scanner_screen.dart';
import 'package:flutter_authenticator/screen/setup_key.dart';
import 'package:flutter_authenticator/widget/custom_drawer.dart';
import 'package:flutter_authenticator/widget/item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static String get routeName => "/HomeScreen";
}

class _HomeScreenState extends State<HomeScreen> {
  // ✅ تابع به داخل کلاس State منتقل شد تا به mounted دسترسی داشته باشد
  Future<void> _startBarcodeScan(BuildContext context) async {
    // ۱. اول باتم‌شیت (منوی پایین) را می‌بندیم
    Navigator.of(context).pop();

    // ۲. رفتن به صفحه اسکنر
    final result = await context.pushNamed(ScannerScreen.routeName);

    if (result != null && result is String) {
      final account = parseOtpUri(result);

      if (account != null) {
        await SecureStorageService.saveAccount(account);
        if (mounted) {
          context.read<AccountBloc>().add(LoadAccountsEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account Saved Securely!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid QR Code!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  // ✅ تابع به داخل کلاس State منتقل شد
  void _showAddOptions(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final bgColor = isDark ? MyColors.black : MyColors.white;
        final textColor = isDark ? Colors.white : Colors.black;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // خط تزیینی بالای منو
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 30),

              // گزینه اول: اسکنر
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: MyColors.salmon.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: MyColors.salmon,
                    size: 28,
                  ),
                ),
                title: Text(
                  'Scan a QR Code',
                  style: TextStyle(
                    fontFamily: 'Cr',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                subtitle: const Text(
                  'Use camera to scan code from another screen',
                ),
                // ✅ مشکل اجرای خودکار حل شد
                onTap: () => _startBarcodeScan(context),
              ),

              const Divider(height: 30, indent: 70, endIndent: 20),

              // گزینه دوم: ورود دستی
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.keyboard_outlined,
                    color: Colors.blue,
                    size: 28,
                  ),
                ),
                title: Text(
                  'Enter Setup Key',
                  style: TextStyle(
                    fontFamily: 'Cr',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                subtitle: const Text('Manually type your account details'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.pushNamed(SetupScreen.routeName);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      drawer: MyDrawer(textTheme: textTheme, isDark: isDark, l10n: l10n),

      floatingActionButton: FloatingActionButton.extended(
        elevation: 4,
        backgroundColor: MyColors.salmon,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () => _showAddOptions(context, l10n),
        icon: const Icon(Icons.add_box_rounded, color: Colors.white, size: 24),
        label: const Text(
          "Add Account",
          style: TextStyle(
            fontFamily: 'Cr',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      appBar: AppBar(title: Text(l10n.title)),

      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadingState) {
            return const Center(
              child: SpinKitFoldingCube(color: MyColors.salmon, size: 40.0),
            );
          }

          if (state is AccountLoadedState) {
            if (state.accounts.isEmpty) {
              return Center(
                child: Text(
                  l10n.accountMessage, // مطمئن شوید این کلید در فایل ترجمه شما هست
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100, top: 8),
              itemCount: state.accounts.length,
              itemBuilder: (context, index) {
                return ItemCardWidget(
                  index: index,
                  l10n: l10n,
                  account: state.accounts[index],
                );
              },
            );
          }

          if (state is AccountErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
