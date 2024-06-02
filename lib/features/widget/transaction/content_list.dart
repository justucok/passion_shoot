import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/bloc/transaction_bloc/transaction_bloc.dart';

class ContentList extends StatelessWidget {
  const ContentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth * 0.9;
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionLoaded) {
          final data = state.transaksis;
          for (var item in data) {
            log(item.date);
          }
          // list transaksi
          return Container(
            width: contentWidth,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    data[index].title,
                    style: primaryTextStyle,
                  ),
                  subtitle: Text(
                    data[index].description,
                  ),
                  trailing: Text(
                    '${data[index].typeid == 1 ? '+' : '-'} Rp.${formatNumberWithDots(data[index].amount)}',
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
    String decimalPart = parts.length > 1 ? ',' + parts[1] : '';

    RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
    String formattedIntegerPart =
        integerPart.replaceAllMapped(regExp, (Match match) => '.');

    return formattedIntegerPart + decimalPart;
  }
}
