import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class ContentList extends StatelessWidget {
  const ContentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}