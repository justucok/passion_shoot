import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key, required this.onPressed});

  final void Function()? onPressed;

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
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: ListView(
          children: [
            TextFormField(
              controller:
                  TextEditingController(text: DateTime.now().toString()),
              readOnly: true,
              // enabled: false,
              decoration:
                  InputDecoration(suffixIcon: Icon(Icons.calendar_today)),
              onTap: () async {
                showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2200),
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Sumber Dana'),
              readOnly: true,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Jumlah',
                suffixIcon: Icon(Icons.attach_money),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Judul'),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Keterangan'),
            ),
          ],
        ),
      ),
    );
  }
}
