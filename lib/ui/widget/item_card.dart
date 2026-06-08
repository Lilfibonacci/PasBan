import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final cardColor = isDark ? const Color(0xFF222224) : Colors.white;
    final shadowColor = isDark ? Colors.transparent : Colors.black12;
    final formattedCode = _currentCode.length == 6
        ? '${_currentCode.substring(0, 3)} ${_currentCode.substring(3, 6)}'
        : _currentCode;
    final progress = _remainingSeconds / 30.0;
    final isExpiring = _remainingSeconds <= 5;
    final textColor = isDark ? Colors.white : Colors.black87;
    final warningColor = isExpiring ? Colors.redAccent : textColor;
    final accentColor = isExpiring
        ? Colors.redAccent
        : isDark
        ? Colors.white
        : Colors.black87;
    final pieBgColor = isDark ? Colors.white10 : Colors.black12;
    final brandIcon = getBrandIcon(widget.account.issuer);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
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
                        color: warningColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.account.accountName,
                      style: textTheme.bodyMedium?.copyWith(
                        color: warningColor.withValues(alpha: 0.7),
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
                              color: warningColor,
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
                                      widget.l10n.copyText,
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
                                color: warningColor.withValues(alpha: 0.6),
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
                    //circlur backGround
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: pieBgColor,
                      ),
                    ),

                    //indicator
                    ClipOval(
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 50,
                        color: accentColor.withValues(alpha: 0.25),
                        backgroundColor: Colors.transparent,
                      ),
                    ),

                    //icon
                    Center(
                      child: brandIcon != null
                          ? FaIcon(brandIcon, color: accentColor, size: 24)
                          : Text(
                              widget.account.issuer.isNotEmpty
                                  ? widget.account.issuer[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                color: accentColor,
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
