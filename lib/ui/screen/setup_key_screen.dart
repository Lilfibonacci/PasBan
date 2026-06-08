import 'package:flutter/material.dart';
import 'package:flutter_authenticator/bloc/account/account_bloc.dart';
import 'package:flutter_authenticator/bloc/account/account_event.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/core/util/secure_storage_services.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/model/otp_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();

  static String get routeName => "/setupScreen";
}

class _SetupScreenState extends State<SetupScreen> {
  late FocusNode nameFocusNode;
  late FocusNode keyFocusNode;
  late FocusNode accountName;
  late TextEditingController accountNameController;
  late TextEditingController nameController;
  late TextEditingController keyController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    keyController = TextEditingController();
    accountNameController = TextEditingController();
    accountName = FocusNode();
    nameFocusNode = FocusNode();
    keyFocusNode = FocusNode();

    nameFocusNode.addListener(() {
      setState(() {});
    });

    accountName.addListener(() {
      setState(() {});
    });

    keyFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    keyController.dispose();
    nameFocusNode.dispose();
    keyFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveAccount() async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text.trim();

      final secret = keyController.text
          .trim()
          .replaceAll(' ', '')
          .toUpperCase()
          .replaceAll('0', 'O')
          .replaceAll('1', 'I');

      final accountName = accountNameController.text.trim();

      final newAccount = OtpModel(
        secret: secret,
        issuer: name,
        accountName: accountName,
      );

      await SecureStorageService.saveAccount(newAccount);

      if (mounted) {
        context.read<AccountBloc>().add(LoadAccountsEvent());

        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    final activeColor = MyColors.salmon;
    final inactiveColor = isDark ? MyColors.white : MyColors.black;
    final typingTextColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.title)),
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            //name field
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15,
                ),
                child: TextFormField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  style: TextStyle(
                    color: typingTextColor,
                    fontSize: 18,
                    fontFamily: "Cr",
                  ),
                  cursorColor: activeColor,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a name'
                      : null,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FaIcon(
                        FontAwesomeIcons.laptopCode,
                        color: nameFocusNode.hasFocus
                            ? activeColor
                            : inactiveColor,
                      ),
                    ),
                    labelText: "issuer",
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: "Cr",
                      color: nameFocusNode.hasFocus
                          ? activeColor
                          : inactiveColor,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor, width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: activeColor, width: 3),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                    ),
                  ),
                ),
              ),
            ),

            //accountName
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15,
                ),
                child: TextFormField(
                  controller: accountNameController,
                  focusNode: accountName,
                  style: TextStyle(
                    color: typingTextColor,
                    fontSize: 18,
                    fontFamily: "Cr",
                  ),
                  cursorColor: activeColor,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a accountName'
                      : null,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FaIcon(
                        FontAwesomeIcons.code,
                        color: accountName.hasFocus
                            ? activeColor
                            : inactiveColor,
                      ),
                    ),
                    labelText: "account Name",
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: "Cr",
                      color: accountName.hasFocus ? activeColor : inactiveColor,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor, width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: activeColor, width: 3),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                    ),
                  ),
                ),
              ),
            ),

            //key field
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15,
                ),
                child: TextFormField(
                  controller: keyController,
                  focusNode: keyFocusNode,
                  style: TextStyle(
                    color: typingTextColor,
                    fontSize: 18,
                    fontFamily: "Cr",
                  ),
                  cursorColor: activeColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the secret key';
                    }
                    final checkStr = value.toUpperCase();
                    if (checkStr.contains('8') || checkStr.contains('9')) {
                      return 'Secret keys never contain 8 or 9!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FaIcon(
                        FontAwesomeIcons.key,
                        color: keyFocusNode.hasFocus
                            ? activeColor
                            : inactiveColor,
                      ),
                    ),
                    labelText: "Secret Key",
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: "Cr",
                      color: keyFocusNode.hasFocus
                          ? activeColor
                          : inactiveColor,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor, width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: activeColor, width: 3),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                    ),
                  ),
                ),
              ),
            ),

            //add button
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 44,
                  ),
                  child: ElevatedButton(
                    onPressed: _saveAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.salmon,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      l10n.addAcount,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
