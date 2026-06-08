import 'package:flutter/material.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/core/util/biometric_service.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/ui/screen/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  static String get routeName => "/LoadingScreen";

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _authFailed = false;

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      Future.delayed(const Duration(seconds: 1), () {
        _checkAuthentication();
      });
    }
  }

  Future<void> _checkAuthentication() async {
    setState(() => _authFailed = false);

    try {
      final isAuthenticated = await BiometricService.authenticate();

      if (isAuthenticated) {
        if (mounted) {
          context.goNamed(HomeScreen.routeName);
        }
      } else {
        if (mounted) {
          setState(() => _authFailed = true);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _authFailed = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/pasbanlogo.png", scale: 0.1),
            if (_authFailed) ...[
              const Icon(
                Icons.lock_outline_rounded,
                size: 48,
                color: MyColors.tomato,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton.icon(
                  onPressed: _checkAuthentication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.salmon,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  icon: const Icon(
                    Icons.fingerprint_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    l10n.unlockAppbutton,
                    style: textTheme.bodyMedium?.copyWith(
                      color: MyColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ] else ...[
              const SpinKitSpinningLines(color: MyColors.salmon, size: 40.0),
            ],
          ],
        ),
      ),
    );
  }
}
