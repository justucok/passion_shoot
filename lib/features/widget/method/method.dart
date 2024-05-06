import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/add_button.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';

class MethodContent extends StatelessWidget {
  const MethodContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Sumber Dana',
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        color: bgColor,
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Total Saldo',
                style: primaryTextStyle,
              ),
              trailing: Text(
                '2.240.000',
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      'BCA',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '470.000',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'BRI',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '0',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Dana',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '220.000',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Gopay',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '0',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Shopeepay',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '0',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Jago',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '0',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Mandiri',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '1.400.000',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'OVO',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '0',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Uang Tunai',
                      style: primaryTextStyle,
                    ),
                    trailing: Text(
                      '150.000',
                      style: primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddButton(onPressed: () {
        
      },),
    );
  }
}
