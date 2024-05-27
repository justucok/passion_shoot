import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
// Import class typeTransaksiData

class MultipleButton extends StatelessWidget {
  const MultipleButton({
    super.key,
    required this.onAddPressed,
    required this.onOutPressed,
  });

  final void Function(int typeid)? onAddPressed;
  final void Function(int typeid)? onOutPressed;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeIcon: Icons.close,
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: alternativeColor),
      children: [
        SpeedDialChild(
          shape: const CircleBorder(),
          backgroundColor: secondaryColor,
          labelWidget: Text(
            'Pemasukan',
            style: primaryTextStyle,
          ),
          child: Icon(
            Icons.attach_money,
            color: secondaryTextColor,
          ),
          onTap: () {
            if (onAddPressed != null) {
              onAddPressed!(1); // Panggil callback dengan typeid 1
            }
          },
        ),
        SpeedDialChild(
          shape: const CircleBorder(),
          backgroundColor: secondaryColor,
          labelWidget: Text(
            'Pengeluaran',
            style: primaryTextStyle,
          ),
          child: Icon(
            Icons.shopping_basket,
            color: secondaryTextColor,
          ),
          onTap: () {
            if (onOutPressed != null) {
              onOutPressed!(2); // Panggil callback dengan typeid 2
            }
          },
        ),
      ],
      child: Icon(
        Icons.add,
        color: alternativeColor,
      ),
    );
  }
}
