import 'package:flutter/material.dart';
import 'package:flutter_authenticator/bloc/account/account_bloc.dart';
import 'package:flutter_authenticator/bloc/account/account_event.dart';
import 'package:flutter_authenticator/bloc/account/account_state.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/core/util/otp_parser.dart';
import 'package:flutter_authenticator/core/util/secure_storage_services.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/screen/scanner_screen.dart';
import 'package:flutter_authenticator/screen/setup_key_screen.dart';
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
  Future<void> _startBarcodeScan(BuildContext context) async {
    Navigator.of(context).pop();

    final result = await context.pushNamed(ScannerScreen.routeName);

    if (result != null && result is String) {
      final account = parseOtpUri(result);

      if (account != null) {
        await SecureStorageService.saveAccount(account);
        if (mounted) {
          context.read<AccountBloc>().add(LoadAccountsEvent());
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

  void _showAddOptions(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final bgColor = isDark ? MyColors.black : MyColors.white;
        final textTheme = Theme.of(context).textTheme;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 30),

              //  Qr scanner
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
                  l10n.buttomSheetScanTitle,
                  style: textTheme.bodyLarge?.copyWith(fontSize: 24),
                ),
                subtitle: Text(
                  l10n.buttomSheetScanSubTitle,
                  style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                ),
                onTap: () => _startBarcodeScan(context),
              ),

              const Divider(height: 30, indent: 70, endIndent: 20),

              //enter manual setup key
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
                  l10n.buttomSheetSetupKeyTitle,
                  style: textTheme.bodyLarge?.copyWith(fontSize: 26),
                ),
                subtitle: Text(
                  l10n.buttomSheetSetupKeySubTitle,
                  style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                ),
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
      //drawer
      drawer: MyDrawer(textTheme: textTheme, isDark: isDark, l10n: l10n),

      //fab
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: FloatingActionButton.extended(
          elevation: 4,
          backgroundColor: MyColors.salmon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onPressed: () => _showAddOptions(context, l10n),

          label: Center(
            child: Text(
              l10n.addAcount,
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
          ),
        ),
      ),

      //appBar
      appBar: AppBar(title: Text(l10n.title)),

      //body
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          //Loading State
          if (state is AccountLoadingState) {
            return const Center(
              child: SpinKitFoldingCube(color: MyColors.salmon, size: 40.0),
            );
          }

          if (state is AccountLoadedState) {
            if (state.accounts.isEmpty) {
              return Center(
                child: Text(
                  l10n.accountMessage,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 100, top: 8),
              itemCount: state.accounts.length,
              itemBuilder: (context, index) {
                final account = state.accounts[index];

                return Dismissible(
                  key: ValueKey(account.secret),

                  direction: DismissDirection.endToStart,

                  background: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.tomato,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24.0),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),

                  //delete dialog
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                            l10n.dialogTitle,
                            style: textTheme.bodyMedium?.copyWith(fontSize: 24),
                          ),
                          content: Text(
                            l10n.dialogContent,
                            style: textTheme.bodyMedium?.copyWith(fontSize: 18),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                l10n.cancelButton,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                l10n.deleteButton,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  //delete event
                  onDismissed: (direction) {
                    context.read<AccountBloc>().add(
                      DeleteAccountEvent(index: index),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          l10n.deleteSnackBar,
                          style: textTheme.bodyMedium?.copyWith(fontSize: 16),
                        ),
                        backgroundColor: MyColors.tomato,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ItemCardWidget(
                      index: index,
                      l10n: l10n,
                      account: account,
                    ),
                  ),
                );
              },
            );
          }

          //error state
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
