import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/api/server-api/apiservices.dart';
import 'package:proj_passion_shoot/features/data/Payment/bank_account.dart';
import 'package:proj_passion_shoot/features/data/transaction/datatransaction.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class MethodList extends StatefulWidget {
  const MethodList({
    Key? key,
  }) : super(key: key);

  @override
  _MethodListState createState() => _MethodListState();
}

class _MethodListState extends State<MethodList> {
  late Future<List<cData>> transactions;
  late Future<List<acData>> paymentMethods;

  @override
  void initState() {
    super.initState();
    transactions = Service().getallTransaction();
    paymentMethods = Service().getmethodpayment();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<acData>>(
      future: paymentMethods,
      builder: (context, paymentSnapshot) {
        if (paymentSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (paymentSnapshot.hasError) {
          return Text('Error: ${paymentSnapshot.error}');
        } else {
          double totalSaldo = 0;
          return FutureBuilder<List<cData>>(
            future: transactions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('Tidak ada data yang tersedia');
              } else {
                Map<String, double> paymentAmounts = {};
                for (var transaction in snapshot.data!) {
                  if (transaction.cpaymentid != null) {
                    String paymentId = transaction.cpaymentid!;
                    double amount = double.parse(transaction.camount);
                    paymentAmounts.update(
                      paymentId,
                      (value) =>
                          value +
                          (transaction.ctypeid == '1' ? amount : -amount),
                      ifAbsent: () =>
                          transaction.ctypeid == '1' ? amount : -amount,
                    );
                  }
                }

                for (var amount in paymentAmounts.values) {
                  totalSaldo += amount;
                }

                Color saldoColor = totalSaldo >= 0 ? succesColor : dangerColor;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Saldo:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${cData.addDotToNumber(totalSaldo.toStringAsFixed(0))}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: saldoColor,
                            ),
                          ),
                        ],
                      ),
                      trailing: SizedBox.shrink(),
                    ),
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

                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              paymentMethod.cmethod,
                              style: primaryTextStyle,
                            ),
                            Text(
                              '${cData.addDotToNumber(finalAmount.toStringAsFixed(0))}',
                              style: primaryTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: finalAmount >= 0
                                    ? succesColor
                                    : dangerColor,
                              ),
                            ),
                          ],
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
