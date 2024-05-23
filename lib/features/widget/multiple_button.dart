import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:proj_passion_shoot/api/apiservices.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/api/typetransaksi.dart'; // Import class typeTransaksiData

class MultipleButton extends StatelessWidget {
  const MultipleButton({
    Key? key,
    required this.addPressed,
    required this.outPressed,
  }) : super(key: key);

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
          onTap: () {
            // Ketika 'Pemasukan' diklik, panggil addPressed
            if (addPressed != null) {
              addPressed!();
              // Panggil fungsi getTypeTransaksi dengan id=1
              getTypeTransaksiById(1); // Memanggil fungsi dengan id=1
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
            // Ketika 'Pengeluaran' diklik, panggil outPressed
            if (outPressed != null) {
              outPressed!();
              // Panggil fungsi getTypeTransaksi dengan id=2
              getTypeTransaksiById(2); // Memanggil fungsi dengan id=2
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

  // Fungsi untuk mengambil data jenis transaksi berdasarkan id
  void getTypeTransaksiById(int id) async {
    try {
      List<typeTransaksiData> type = await Service().getTypeTransaksi();
      // Filter jenis transaksi berdasarkan id yang sesuai
      typeTransaksiData selectedType =
          type.firstWhere((element) => element.cid == id.toString());
      // Gunakan data jenis transaksi yang telah dipilih
      print('Jenis transaksi dipilih: ${selectedType.ctype_transaksi}');
    } catch (e) {
      print('Gagal mengambil data jenis transaksi: $e');
    }
  }
}
