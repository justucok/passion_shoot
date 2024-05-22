import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/api/apiservices.dart';
import 'package:proj_passion_shoot/api/datatransaction.dart';

class MethodList extends StatefulWidget {
  const MethodList({
    Key? key,
  }) : super(key: key);

  @override
  _MethodListState createState() => _MethodListState();
}

class _MethodListState extends State<MethodList> {
  late Future<List<cData>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = Service().getallTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<cData>>(
      future: transactions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          // Group transactions by cpaymentid
          Map<String, double> paymentAmounts = {};
          for (var transaction in snapshot.data!) {
            if (transaction.cpaymentid != null) {
              String paymentId = transaction.cpaymentid!;
              double amount = double.parse(transaction.camount);
              paymentAmounts.update(
                paymentId,
                (value) =>
                    value + (transaction.ctypeid == '1' ? amount : -amount),
                ifAbsent: () => transaction.ctypeid == '1' ? amount : -amount,
              );
            }
          }

          // Calculate total saldo
          double totalSaldo =
              paymentAmounts.values.fold(0, (prev, amount) => prev + amount);
          // Determine text color based on total saldo value
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
              ...paymentAmounts.entries.map((entry) {
                String? method;
                for (var transaction in snapshot.data!) {
                  if (transaction.cpaymentid == entry.key) {
                    method = transaction.cmethod;
                    break;
                  }
                }

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        method ?? 'Unknown Method',
                        style: primaryTextStyle,
                      ),
                      Text(
                        '${cData.addDotToNumber(entry.value.toStringAsFixed(0))}',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: entry.value >= 0 ? succesColor : dangerColor,
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
}
