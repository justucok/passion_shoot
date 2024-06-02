// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/bloc/payment_method_bloc.dart';
import 'package:proj_passion_shoot/features/data/datasource/api_service.dart';
import 'package:proj_passion_shoot/features/data/model/payment/get_payment_method.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/get_transaction.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class MethodList extends StatefulWidget {
  const MethodList({
    super.key,
  });

  @override
  _MethodListState createState() => _MethodListState();
}

class _MethodListState extends State<MethodList> {
  late Future<List<TransactionData>> transactions;
  late Future<List<PaymentData>> paymentMethods;

  @override
  void initState() {
    super.initState();
    transactions = Service().getallTransaction();
    paymentMethods = Service().getmethodpayment();
  }

  @override
  Widget build(BuildContext context) {
    return 
    // BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
    //   builder: (context, state) {
    //     if (state is PaymentMethodLoading) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else if (state is PaymentMethodLoaded) {
    //       final data = state.methods;
    //       print(data.toString());
    //       return Column(
    //         children: [
    //           ListTile(
    //             title: Text(
    //               'Total Saldo:',
    //               style: primaryTextStyle,
    //             ),
    //             trailing: Text(data.toString()),
    //           )
    //         ],
    //       );
    //     } else if (state is PaymentMethodError) {
    //       return Center(
    //         child: Text(state.error),
    //       );
    //     }
    //     return const Text('gagal memuat data');
    //   },
    // );
    FutureBuilder<List<PaymentData>>(
      future: paymentMethods,
      builder: (context, paymentSnapshot) {
        if (paymentSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (paymentSnapshot.hasError) {
          return Text('Error: ${paymentSnapshot.error}');
        } else {
          //keadaan awal nilai dari total saldo
          double totalSaldo = 0;
          return FutureBuilder<List<TransactionData>>(
            future: transactions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Tidak ada data yang tersedia');
              } else {
                Map<String, double> paymentAmounts = {};
                for (var transaction in snapshot.data!) {
                  String paymentId = transaction.cpaymentid;
                  double amount = double.parse(transaction.camount);
                  paymentAmounts.update(
                    paymentId,
                    (value) =>
                        value + (transaction.ctypeid == '1' ? amount : -amount),
                    ifAbsent: () =>
                        transaction.ctypeid == '1' ? amount : -amount,
                  );
                }

                for (var amount in paymentAmounts.values) {
                  totalSaldo += amount;
                }
                Color saldoColor = totalSaldo >= 0 ? succesColor : dangerColor;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: const Text(
                        'Total Saldo:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        TransactionData.addDotToNumber(
                            totalSaldo.toStringAsFixed(0)),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: saldoColor,
                        ),
                      ),
                    ),
                    //penghitungan dari total saldo
                    ...paymentSnapshot.data!.map((paymentMethod) {
                      var transactionsForMethod = snapshot.data!
                          .where((transaction) =>
                              transaction.cpaymentid == paymentMethod.cid)
                          .toList();

                      double totalAmount1 = transactionsForMethod.fold(
                          0,
                          (prev, transaction) =>
                              prev +
                              (transaction.ctypeid == '1'
                                  ? double.parse(transaction.camount)
                                  : 0));

                      double totalAmount2 = transactionsForMethod.fold(
                          0,
                          (prev, transaction) =>
                              prev +
                              (transaction.ctypeid == '2'
                                  ? double.parse(transaction.camount)
                                  : 0));
                      double finalAmount = totalAmount1 - totalAmount2;
                      return SingleChildScrollView(
                        child: ListTile(
                          title: Text(
                            paymentMethod.cmethod,
                            style: primaryTextStyle,
                          ),
                          trailing: Text(
                            TransactionData.addDotToNumber(
                                finalAmount.toStringAsFixed(0)),
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  finalAmount >= 0 ? succesColor : dangerColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }
}
