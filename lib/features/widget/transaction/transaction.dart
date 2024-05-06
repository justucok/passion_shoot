import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/features/pages/transaction/transaction.dart';
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
    return Scaffold(
      // App bar
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: DatepickerAppBar(),
      ),
      // end app bar
      body: const Column(
        children: [
          // status bar
          StatusBar(),
          // end status bar
          Expanded(
            child: ContentList(),
          )
        ],
      ),
      // add button
      floatingActionButton: MultipleButton(
        addPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<dynamic>(
              builder: (context) => TransactionScreen(onPressed: () {  },)
            ),
          );
        },
        outPressed: () {},
      ),
      // end add button
    );
  }
}
