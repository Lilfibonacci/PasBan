sealed class AccountEvent {}

class LoadAccountsEvent extends AccountEvent {}

class DeleteAccountEvent extends AccountEvent {
  final int index;
  DeleteAccountEvent({required this.index});
}
