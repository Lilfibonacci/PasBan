import 'package:flutter_authenticator/model/otp_model.dart';

abstract class AccountState {}

// حالت اولیه و در حال بارگذاری
class AccountLoading extends AccountState {}

// حالتی که اکانت‌ها با موفقیت از دیتابیس خوانده شدند
class AccountLoaded extends AccountState {
  final List<OtpModel> accounts;

  AccountLoaded({required this.accounts});
}

// در صورت بروز خطا
class AccountError extends AccountState {
  final String message;

  AccountError({required this.message});
}
