
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:proj_passion_shoot/features/data/datasource/dio/remote_datasource.dart';
import 'package:proj_passion_shoot/features/pages/transaction/add_transaction.dart';
import 'package:proj_passion_shoot/features/widget/multiple_button.dart';
import 'package:proj_passion_shoot/features/widget/transaction/content_list.dart';
import 'package:proj_passion_shoot/features/widget/transaction/datepicker_app_bar.dart';
import 'package:proj_passion_shoot/features/widget/transaction/statusbar.dart';

class TransactionContent extends StatefulWidget {
  const TransactionContent({
    super.key,
  });

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent> {
  @override
  Widget build(BuildContext context) {
    // datetime to filter data
    DateTime selectedDate = DateTime.now();
    // log(selectedDate.toString());
    return BlocProvider(
      create: (context) => TransactionBloc(remotedatasource: RemoteDataSource())
        ..add(LoadTransactions()),
      child: Scaffold(
        // App bar
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: DatepickerAppBar(
            selectDate: selectedDate,
          ),
        ),
        // end app bar
        body: const Column(
          children: [
            // status bar
            StatusBar(),
            // end status bar
            // content
            Expanded(
              child: ContentList(),
              // ContentList(),
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
      ),
    );
  }
}

