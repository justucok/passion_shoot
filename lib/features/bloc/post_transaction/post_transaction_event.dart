part of 'post_transaction_bloc.dart';

@immutable
sealed class PostTransactionEvent {}

final class PostDataTransaction extends PostTransactionEvent {
  
  final TransactionBody body;

  PostDataTransaction({required this.body});
}
