import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/transaction/transaction_form.dart';

// ignore: must_be_immutable
class TransactionScreen extends StatelessWidget {
  TransactionScreen({super.key, required this.onPressed});

  final dynamic Function() onPressed;

  DateTime selectedDate = DateTime.now();

  dynamic selectedValue;

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
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          width: double.infinity,
          child: TransactionForm(
            selectedDate: selectedDate,
            selectedValue: selectedValue,
            onPressed: onPressed,
          )),
    );
  }
}
