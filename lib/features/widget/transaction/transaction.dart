import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:proj_passion_shoot/features/widget/transaction/content_list.dart';
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
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      // App bar
      // end app bar
      body: Column(
        children: [
          Container(
            color: primaryColor,
            width: double.infinity,
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000),
                ).then((value) {
                  setState(() {
                    selectedDate = value!;
                  });
                });
              },
              child: Text(
                DateFormat('E, d MMM yyyy').format(selectedDate),
                style: secondaryTextStyle.copyWith(fontSize: 18),
              ),
            ),
          ),
          // status bar
          StatusBar(),
          // end status bar
          Expanded(
            child: ContentList(),
          )
        ],
      ),
      // add button
      floatingActionButton: AddButton(
        onPressed: () {},
      ),
      // end add button
    );
  }
}
