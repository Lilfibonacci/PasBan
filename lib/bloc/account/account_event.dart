abstract class AccountEvent {}

// رویدادی که به BLoC می‌گوید دیتابیس را بخوان
class LoadAccountsEvent extends AccountEvent {}
