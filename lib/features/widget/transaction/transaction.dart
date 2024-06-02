import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/bloc/transaction_bloc.dart';
import 'package:proj_passion_shoot/features/data/datasource/dio/remote_datasource.dart';
import 'package:proj_passion_shoot/features/pages/transaction/add_transaction.dart';
import 'package:proj_passion_shoot/features/widget/multiple_button.dart';
import 'package:proj_passion_shoot/features/widget/transaction/content_list.dart';
import 'package:proj_passion_shoot/features/widget/transaction/datepicker_app_bar.dart';
import 'package:proj_passion_shoot/features/widget/transaction/statusbar.dart';

class TransactionContent extends StatelessWidget {
  const TransactionContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(RemoteDataSource())..add(LoadTransaction()),
      child: Scaffold(
        // App bar
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: DatepickerAppBar(),
        ),
        // end app bar
        body: Column(
          children: [
            // status bar
            const StatusBar(),
            // end status bar
            Expanded(child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TransactionLoaded) {
                  final data = state.transactions;
                  log(data.toString());
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      ListTile(
                        title: Text(data[index].title),
                        trailing: Text('${data[index].amount}'),
                      );
                      return const Center(
                        child: Text('Tidak ada transaksi'),
                      );
                    },
                  );
                } else if (state is TransactionError) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return const Center(
                  child: Text('Gagal memuat data'),
                );
              },
            )
                // ContentList(),
                )
          ],
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
