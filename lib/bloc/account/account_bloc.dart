import 'package:flutter_authenticator/core/util/secure_storage_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountLoadingState()) {
    on<LoadAccountsEvent>((event, emit) async {
      emit(AccountLoadingState());

      try {
        final accounts = await SecureStorageService.getAccounts();

        emit(AccountLoadedState(accounts: accounts));
      } catch (e) {
        emit(AccountErrorState(message: "خطا در بارگذاری اطلاعات"));
      }
    });
  }
}
