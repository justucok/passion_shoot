import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class MultipleButton extends StatelessWidget {
  const MultipleButton({
    super.key,
    required this.addPressed,
    required this.outPressed,
  });

  final void Function()? addPressed;
  final void Function()? outPressed;

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
            onTap: addPressed),
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
          onTap: outPressed,
        ),
      ],
      child: Icon(
        Icons.add,
        color: alternativeColor,
      ),
    );
  }
}
