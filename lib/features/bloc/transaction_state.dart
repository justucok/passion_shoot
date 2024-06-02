part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  final List<Transaksi> transaksis;

  TransactionLoaded(this.transaksis);
}

final class TransactionEror extends TransactionState {
  final String error;
  TransactionEror(this.error);
}
