import 'package:flutter_authenticator/model/otp_model.dart';

sealed class AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState extends AccountState {
  final List<OtpModel> accounts;

  AccountLoadedState({required this.accounts});
}

class AccountErrorState extends AccountState {
  final String message;

  AccountErrorState({required this.message});
}
