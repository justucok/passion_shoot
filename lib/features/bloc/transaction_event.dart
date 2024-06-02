part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class LoadTransactionsForDate extends TransactionEvent {
  final String selectedDate;
  LoadTransactionsForDate(this.selectedDate);
}
