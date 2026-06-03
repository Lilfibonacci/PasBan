import 'package:flutter_authenticator/core/util/secure_storage_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountLoading()) {
    // وقتی رویداد LoadAccountsEvent صدا زده شد، این تابع اجرا می‌شود
    on<LoadAccountsEvent>((event, emit) async {
      emit(AccountLoading()); // ابتدا وضعیت را روی لودینگ می‌گذاریم

      try {
        // خواندن لیست از دیتابیس امن
        final accounts = await SecureStorageService.getAccounts();

        // فرستادن لیست به صفحه اصلی
        emit(AccountLoaded(accounts: accounts));
      } catch (e) {
        emit(AccountError(message: "خطا در بارگذاری اطلاعات"));
      }
    });
  }
}
