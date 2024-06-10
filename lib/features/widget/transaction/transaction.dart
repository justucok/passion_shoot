import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/core/network/remote_datasource.dart';
import 'package:proj_passion_shoot/features/bloc/get_transaction/transaction_bloc.dart';
import 'package:proj_passion_shoot/features/pages/transaction/add_transaction.dart';
import 'package:proj_passion_shoot/features/widget/multiple_button.dart';
// import 'package:proj_passion_shoot/features/widget/transaction/content_list.dart';
// import 'package:proj_passion_shoot/features/widget/transaction/datepicker_app_bar.dart';
import 'package:proj_passion_shoot/features/widget/transaction/statusbar.dart';

class TransactionContent extends StatefulWidget {
  const TransactionContent({
    super.key,
  });

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    // change value selectDate
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        log(selectedDate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // datetime to filter data
    // log(selectedDate.toString());
    return BlocProvider(
      create: (context) => TransactionBloc(remotedatasource: RemoteDataSource())..add(LoadTransactions()),
      child: BlocBuilder<TransactionBloc, TransactionState>(
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
                    DateFormat('yyyy-MM-dd').format(selectedDate))
                .toList();
            // log('spesific data: ');
            for (var item in data) {
              log('data: ${item.title} date: ${item.date} amount: ${item.amount}');
            }
            return Scaffold(
              // App bar
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: primaryColor,
                centerTitle: true,
                // menampilkan value selectDate
                title: Text(
                  DateFormat('E, d MMM yyyy').format(selectedDate),
                  style: secondaryTextStyle.copyWith(fontSize: 18),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: secondaryTextColor,
                    ),
                    // menampilkan datepicker
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              // end app bar
              body: Column(
                children: [
                  // status bar
                  const StatusBar(),
                  // end status bar
                  // content
                  Expanded(
                    // list transaksi
                    child: SizedBox(
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
                              '${spesificData[index].typeid == 1 ? '+' : '-'} Rp.${formatNumberWithDots(spesificData[index].amount)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: spesificData[index].typeid == 1
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // end list transaksi
                  ),
                ],
                // end content
              ),
              // add button
              floatingActionButton: MultipleButton(
                onAddPressed: (int typeid) {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (context) => TransactionScreen(
                        selectedTypeId: typeid, // Meneruskan typeid
                        selectedDate: DateTime.now(), // Mengatur selectedDate
                      ),
                    ),
                  );
                },
                onOutPressed: (int typeid) {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (context) => TransactionScreen(
                        selectedTypeId: typeid, // Meneruskan typeid
                        selectedDate: DateTime.now(), // Mengatur selectedDate
                      ),
                    ),
                  );
                },
              ),
              // end add button
            );
          } else if (state is TransactionError) {
            return Center(
              child: Text(state.error),
            );
          }
          return const Text('Gagal Memuat Data');
        },
      ),
    );
  }

  String formatNumberWithDots(double number) {
    String numStr = number.toStringAsFixed(2);
    List<String> parts = numStr.split('.');
    String integerPart = parts[0];

    RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
    String formattedIntegerPart =
        integerPart.replaceAllMapped(regExp, (Match match) => '.');

    return formattedIntegerPart;
  }
}
