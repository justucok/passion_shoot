
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/data/datasource/dio/remote_datasource.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final RemoteDataSource remoteDataSource;
  TransactionBloc(this.remoteDataSource) : super(TransactionInitial()) {
    on<LoadTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        final result = await remoteDataSource.getTransaction();
        emit(TransactionLoaded(result.data));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}
