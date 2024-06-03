import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/bloc/get_transaction/transaction_bloc.dart';

// ignore: must_be_immutable
class ContentList extends StatelessWidget {
  ContentList({
    super.key,
    required this.selectedDate,
  });

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionLoaded) {
          final data = state.transaksis;
          final spesificData = data
              .where((element) =>
                  element.date ==
                  DateFormat('yyyy-MM-dd').format(selectedDate!))
              .toList();
              log(spesificData.toString());
          for (var item in data) {
            log(item.date);
          }
          // list transaksi
          return SizedBox(
            width: double.infinity,
            child: ListView.builder(
              itemCount: spesificData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    spesificData[index].title,
                    style: primaryTextStyle,
                  ),
                  subtitle: Text(
                    spesificData[index].description,
                  ),
                  trailing: Text(
                    '${spesificData[index].typeid == 1 ? '+' : '-'} Rp.${formatNumberWithDots(data[index].amount)}',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          data[index].typeid == 1 ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          );
          // end list transaksi
        } else if (state is TransactionError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const Text('Gagal Memuat Data');
      },
    );
  }

  String formatNumberWithDots(double number) {
    String numStr = number.toStringAsFixed(2);
    List<String> parts = numStr.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? ',${parts[1]}' : '';

    RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
    String formattedIntegerPart =
        integerPart.replaceAllMapped(regExp, (Match match) => '.');

    return formattedIntegerPart + decimalPart;
  }
}
