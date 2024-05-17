import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class DetailList extends StatelessWidget {
  const DetailList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double contentWidth = screenWidth * 0.9; // 90% dari lebar layar
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: secondaryTextColor,
                borderRadius: BorderRadius.circular(9)
              ),
              child: Center(
                child: Text(
                  '01 May 2024 - 31 May 2024',
                  style: primaryTextStyle.copyWith(color: primaryColor, fontSize: 16),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Saldo Awal',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                '0',
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Pengeluaran',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                '850.000',
                style:
                    primaryTextStyle.copyWith(fontSize: 14, color: dangerColor),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Pemasukan',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                '+2.000.000',
                style:
                    primaryTextStyle.copyWith(fontSize: 14, color: succesColor),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Selisih',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                '+1.150.000',
                style:
                    primaryTextStyle.copyWith(fontSize: 14, color: succesColor),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Koreksi Saldo',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                '+1.090.000',
                style:
                    primaryTextStyle.copyWith(fontSize: 14, color: succesColor),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                'Saldo Akhir',
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
              trailing: Text(
                '2.240.000',
                style: primaryTextStyle.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
