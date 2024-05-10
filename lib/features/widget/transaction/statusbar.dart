import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth * 0.9; // 80% dari lebar layar

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: alternativeColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.all(12),
        height: 80,
        width: contentWidth, // Menggunakan lebar yang sudah dihitung
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
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
            ),
            SizedBox(
              width: screenWidth * 0.05, // 5% dari lebar layar
            ),
            Expanded(
              child: Column(
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
            ),
            SizedBox(
              width: screenWidth * 0.05, // 5% dari lebar layar
            ),
            Expanded(
              child: Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
