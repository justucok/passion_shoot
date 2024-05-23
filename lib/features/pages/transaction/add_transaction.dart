import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/api/apiservices.dart';
import 'package:proj_passion_shoot/api/bank_account.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/transaction/transaction_form.dart';

class TransactionScreen extends StatelessWidget {
  final dynamic Function() onPressed;

  TransactionScreen({Key? key, required this.onPressed}) : super(key: key);

  DateTime selectedDate = DateTime.now();
  late acData selectedPayment; // Inisialisasi selectedPayment

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Tambah Transaksi',
          leading: BackButton(
            color: secondaryTextColor,
          ),
        ),
      ),
      body: FutureBuilder<List<acData>>(
        future: Service().getmethodpayment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Ambil data pertama dari hasil Future
            selectedPayment = snapshot.data!.first;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              width: double.infinity,
              child: TransactionForm(
                selectedDate: selectedDate,
                selectedValue: selectedPayment,
                onPressed: onPressed,
                selectedTypeId: null,
                getSelectedTypeId: (int) {},
              ),
            );
          }
        },
      ),
    );
  }
}
