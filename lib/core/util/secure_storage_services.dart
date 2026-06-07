import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_authenticator/model/otp_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const _accountsKey = 'pasban_accounts';

  static Future<List<OtpModel>> getAccounts() async {
    try {
      final String? data = await _storage.read(key: _accountsKey);

      if (data != null && data.isNotEmpty) {
        final List<dynamic> decodedList = json.decode(data);

        return decodedList.map((item) => OtpModel.fromMap(item)).toList();
      }
    } catch (e) {
      debugPrint("❌ Error reading accounts from storage: $e");
    }
    return [];
  }

  static Future<void> saveAccount(OtpModel newAccount) async {
    try {
      final List<OtpModel> currentAccounts = await getAccounts();

      final isDuplicate = currentAccounts.any(
        (acc) => acc.secret == newAccount.secret,
      );
      if (isDuplicate) {
        debugPrint("⚠️ این اکانت قبلاً در پاس‌بان ذخیره شده است.");
        return;
      }

      currentAccounts.add(newAccount);

      final String encodedData = json.encode(
        currentAccounts.map((acc) => acc.toMap()).toList(),
      );

      await _storage.write(key: _accountsKey, value: encodedData);
    } catch (e) {
      debugPrint("❌ Error saving account: $e");
    }
  }
}
