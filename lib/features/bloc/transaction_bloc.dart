import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/data/datasource/remote_source.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final RemoteDataSource remotedatasource;

  TransactionBloc({required this.remotedatasource})
      : super(TransactionInitial()) {
    on<LoadTransactionsForDate>((event, emit) async {
      emit(TransactionLoading());
      try {
        final result = await remotedatasource
            .getTransaksi(); // Implementasikan pemanggilan dengan parameter tanggal
        emit(TransactionLoaded(result.data));
      } catch (e) {
        emit(TransactionEror(e.toString()));
      }
    });
  }
}
