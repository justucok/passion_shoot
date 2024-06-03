import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/response/event_response.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/post_event.dart';
import 'package:proj_passion_shoot/features/data/model/payment/response/payment_response.dart';
import 'package:proj_passion_shoot/features/data/model/payment/post_payment_method.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/body/transaction_body.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/post_transaction.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/response/transaction_response.dart';

class RemoteDataSource {
  final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  Future<DataTransaksi> getTransaction() async {
    final response = await dio.get('/all_transaksi');
    return DataTransaksi.fromJson(response.data);
  }

  Future<DataPaymentMethod> getPaymentMethod() async {
    final response = await dio.get('/payment_method');
    return DataPaymentMethod.fromJson(response.data);
  }

  Future<DataEvent> getEvent() async {
    final response = await dio.get('/event');
    log('message from dio : ${response.data}');
    return DataEvent.fromJson(response.data);
  }

  Future<void> postTransaksi(DataTransaksi dataTransaksi) async {
    try {
      final response =
          await dio.post('/all_transaksi', data: dataTransaksi.toJson());
      if (response.statusCode == 201) {
        // Berhasil melakukan posting data
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  /* Future<void> postTransaction(Tra body) async {
    try {
      final response =
          await dio.post('/all_transaksi', data: body.toJson());
      if (response.statusCode == 201) {
        // Berhasil melakukan posting data
      } else {
        throw Exception('Failed to post transaction');
      }
    } catch (e) {
      throw Exception('Failed to post transaction: $e');
    }
  } */

  Future<void> postPaymentMethod(PostPaymentMethod paymentMethod) async {
    try {
      final response =
          await dio.post('/payment_method', data: paymentMethod.toJson());
      if (response.statusCode == 201) {
        // Berhasil melakukan posting data
      } else {
        throw Exception('Failed to post payment method');
      }
    } catch (e) {
      throw Exception('Failed to post payment method: $e');
    }
  }

  Future<void> postEvent(PostEvent event) async {
    try {
      final response = await dio.post('/event', data: event.toJson());
      if (response.statusCode == 201) {
        // Berhasil melakukan posting data
      } else {
        throw Exception('Failed to post event');
      }
    } catch (e) {
      throw Exception('Failed to post event: $e');
    }
  }
}
