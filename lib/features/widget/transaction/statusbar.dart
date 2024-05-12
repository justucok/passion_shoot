import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: alternativeColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(12),
      height: 80,
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
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
    );
  }
}
