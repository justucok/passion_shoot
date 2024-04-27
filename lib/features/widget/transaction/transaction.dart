import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';

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
      appBar: AppBar(
        title: TextButton(
          onPressed: () async {
            final DateTime? dateTime = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(3000),
            );
            if (dateTime != null) {
              setState(
                () {
                  selectedDate = dateTime;
                },
              );
            }
          },
          child: Text(
            DateFormat('E, d MMM yyyy').format(selectedDate),
            style: secondaryTextStyle.copyWith(fontSize: 18),
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          Icon(
            Icons.money,
            color: secondaryTextColor,
          )
        ],
      ),
      // end app bar
      body: Column(
        children: [
          // status bar
          Container(
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(9),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            padding: const EdgeInsets.all(12),
            height: 80,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pemasukan',
                      style: primaryTextStyle,
                    ),
                    Text(
                      '+ 2.000.000',
                      style: TextStyle(color: succesColor),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 80,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pengeluaran',
                      style: primaryTextStyle,
                    ),
                    Text(
                      '850.000',
                      style: TextStyle(color: dangerColor),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 80,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selisih',
                      style: primaryTextStyle,
                    ),
                    Text(
                      '+ 1.150.000',
                      style: primaryTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // end status bar
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(9),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: ListView(
                children: [
                  // list content
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      'Gaji Bulanan',
                      style: primaryTextStyle,
                    ),
                    subtitle: const Text('Gaji Bulanan'),
                    trailing: Text(
                      '+2.000.000',
                      style: primaryTextStyle.copyWith(
                          color: succesColor, fontSize: 14),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      'Belanja Bulanan',
                      style: primaryTextStyle,
                    ),
                    subtitle: const Text('Belanja'),
                    trailing: Text(
                      '-500.000',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      'Jajan',
                      style: primaryTextStyle,
                    ),
                    subtitle: const Text('Jajan'),
                    trailing: Text(
                      '-350.000',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  // end list content
                ],
              ),
            ),
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
