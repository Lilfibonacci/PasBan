import 'package:flutter_authenticator/model/otp_model.dart';

OtpModel? parseOtpUri(String uriString) {
  //otpauth://totp/GitHub:user@email.com?
  //secret=JBSWY3DPEHPK3PXP&issuer=GitHub

  try {
    final uri = Uri.parse(uriString);

    if (uri.scheme != 'otpauth' || uri.host != 'totp') {
      return null;
    }

    final secret = uri.queryParameters['secret'];
    if (secret == null || secret.isEmpty) {
      return null;
    }

    String issuer = uri.queryParameters['issuer'] ?? 'Unknown';

    String path = uri.path;
    if (path.startsWith('/')) {
      path = path.substring(1);
    }

    String accountName = '';

    if (path.contains(':')) {
      final parts = path.split(':');
      issuer = parts[0].trim();
      accountName = parts[1].trim();
    } else {
      accountName = path;
    }

    issuer = Uri.decodeComponent(issuer);
    accountName = Uri.decodeComponent(accountName);

    return OtpModel(secret: secret, issuer: issuer, accountName: accountName);
  } catch (e) {
    return null;
  }
}
