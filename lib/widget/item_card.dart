import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_authenticator/core/constants/my_colors.dart';
import 'package:flutter_authenticator/core/util/fa_icon.dart';
import 'package:flutter_authenticator/l10n/app_localizations.dart';
import 'package:flutter_authenticator/model/otp_model.dart';
import 'package:flutter_authenticator/core/util/totp_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemCardWidget extends StatefulWidget {
  final int index;
  final AppLocalizations l10n;
  final OtpModel account;

  const ItemCardWidget({
    super.key,
    required this.index,
    required this.l10n,
    required this.account,
  });

  @override
  State<ItemCardWidget> createState() => _ItemCardWidgetState();
}

class _ItemCardWidgetState extends State<ItemCardWidget> {
  late Timer _timer;
  int _remainingSeconds = 30;
  String _currentCode = "";

  @override
  void initState() {
    super.initState();
    _updateCodeAndTime();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCodeAndTime();
    });
  }

  void _updateCodeAndTime() {
    final now = DateTime.now();
    final seconds = now.second;

    setState(() {
      _remainingSeconds = 30 - (seconds % 30);
      _currentCode = TotpHelper.generateCode(widget.account.secret);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    final cardColor = MyColors.cardColorsList.reversed
        .toList()[widget.index % MyColors.cardColorsList.length]
        .shade400;

    final formattedCode = _currentCode.length == 6
        ? '${_currentCode.substring(0, 3)} ${_currentCode.substring(3, 6)}'
        : _currentCode;

    final progress = _remainingSeconds / 30.0;
    final isExpiring = _remainingSeconds <= 5;

    final sliceColor = isExpiring
        ? Colors.red.shade900
        : Colors.white.withValues(alpha: 0.3);

    final brandIcon = getBrandIcon(widget.account.issuer);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.account.issuer,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.account.accountName,
                      style: textTheme.bodyMedium?.copyWith(
                        color: isDark ? MyColors.white : MyColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            formattedCode,
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: isDark ? MyColors.white : MyColors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        //copy button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () async {
                              await Clipboard.setData(
                                ClipboardData(text: _currentCode),
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      l10n.copyText,
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                    backgroundColor: Colors.green.shade600,
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.copy_rounded,
                                color: isDark ? MyColors.white : MyColors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 50,
                width: 50,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    ClipOval(
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 50,
                        color: sliceColor,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Center(
                      child: brandIcon != null
                          ? FaIcon(brandIcon, color: Colors.white, size: 24)
                          : Text(
                              widget.account.issuer.isNotEmpty
                                  ? widget.account.issuer[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
