import 'dart:convert';

class OtpModel {
  final String secret;
  final String issuer;
  final String accountName;

  OtpModel({
    required this.secret,
    required this.issuer,
    required this.accountName,
  });

  Map<String, dynamic> toMap() {
    return {'secret': secret, 'issuer': issuer, 'accountName': accountName};
  }

  factory OtpModel.fromMap(Map<String, dynamic> map) {
    return OtpModel(
      secret: map['secret'] ?? '',
      issuer: map['issuer'] ?? '',
      accountName: map['accountName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpModel.fromJson(String source) =>
      OtpModel.fromMap(json.decode(source));
}
