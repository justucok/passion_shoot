part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

final class LoadTransaction extends TransactionEvent {}
