import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/data/datasource/api_service.dart';
import 'package:proj_passion_shoot/features/data/model/payment/get_payment_method.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final Service remoteDataSource;
  PaymentMethodBloc(this.remoteDataSource) : super(PaymentMethodInitial()) {
    on<LoadPaymentMethod>((event, emit) async {
      emit(PaymentMethodLoading());
      try {
        final result = await remoteDataSource.getmethodpayment();
        emit(PaymentMethodLoaded(result));
      } catch (e) {
        emit(PaymentMethodError(e.toString()));
      }
    });
  }
}
