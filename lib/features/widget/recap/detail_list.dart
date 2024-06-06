import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/get_transaction.dart';

class DetailList extends StatelessWidget {
  final List<TransactionData> transactions;

  const DetailList({
    super.key,
    required this.transactions,
  });

  String formatNumber(String number) {
    if (number.isEmpty) return '0';
    String result = '';
    int count = 0;
    for (int i = number.length - 1; i >= 0; i--) {
      result = number[i] + result;
      count++;
      if (count % 3 == 0 && i != 0) {
        result = '.$result';
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double totalIncome = 0;
    double totalExpenses = 0;

    for (var transaction in transactions) {
      double amount = double.tryParse(transaction.camount) ?? 0;
      if (transaction.ctypeid == '1') {
        totalIncome += amount;
      } else if (transaction.ctypeid == '2') {
        totalExpenses += amount;
      }
    }

    double balance = totalIncome - totalExpenses;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: secondaryTextColor,
                  borderRadius: BorderRadius.circular(9)),
              child: Center(
                child: Text(
                  '${DateFormat('01 MMM yyyy').format(DateTime.now())} - ${DateFormat('30 MMM yyyy').format(DateTime.now())}',
                  style: primaryTextStyle.copyWith(
                      color: primaryColor, fontSize: 16),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Saldo Awal',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                '0', // Assuming starting balance is zero
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Pengeluaran',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                formatNumber(totalExpenses.toStringAsFixed(0)),
                style:
                    primaryTextStyle.copyWith(fontSize: 14, color: dangerColor),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Pemasukan',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                '+${formatNumber(totalIncome.toStringAsFixed(0))}',
                style:
                    primaryTextStyle.copyWith(fontSize: 14, color: succesColor),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Selisih',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                formatNumber(balance.toStringAsFixed(0)),
                style:
                    primaryTextStyle.copyWith(fontSize: 14, color: succesColor),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Saldo Akhir',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                formatNumber(balance.toStringAsFixed(0)),
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
