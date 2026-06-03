import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_authenticator/bloc/account/account_bloc.dart';
import 'package:flutter_authenticator/bloc/account/account_event.dart';
import 'package:flutter_authenticator/bloc/account/account_state.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/core/util/otp_parser.dart';
import 'package:flutter_authenticator/core/util/secure_storage_services.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/screen/scanner_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      //drawer
      drawer: MyDrawer(textTheme: textTheme, isDark: isDark, l10n: l10n),

      // fab
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () async {
          final result = await context.pushNamed(ScannerScreen.routeName);

          if (result != null && result is String) {
            final account = parseOtpUri(result);

            if (account != null) {
              await SecureStorageService.saveAccount(account);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.addAcountSuccessMessage),
                    backgroundColor: Colors.green,
                  ),
                );

                await SecureStorageService.saveAccount(account);

                if (context.mounted) {
                  context.read<AccountBloc>().add(LoadAccountsEvent());
                }
              }
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.addAcountFailureMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          }
        },
        icon: const Icon(Icons.add_circle_outline_rounded, size: 24),
        label: Text(
          l10n.addAcount,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),

      //appBar
      appBar: AppBar(title: Text(l10n.title)),

      // body
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(
              child: SpinKitFoldingCube(color: MyColors.salmon, size: 40.0),
            );
          }

          if (state is AccountLoaded) {
            if (state.accounts.isEmpty) {
              return Center(
                child: Text(
                  l10n.accountMessage,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
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

          if (state is AccountError) {
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
