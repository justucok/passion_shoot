import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/api/server-api/apiservices.dart';
import 'package:proj_passion_shoot/features/data/transaction/datatransaction.dart';
import 'package:proj_passion_shoot/utils/color.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  double totalPemasukan = 0;
  double totalPengeluaran = 0;

  @override
  void initState() {
    super.initState();
    fetchAndCalculateTotalPemasukan();
  }

  Future<void> fetchAndCalculateTotalPemasukan() async {
    try {
      List<cData> transactions = await Service().getallTransaction();
      double totalPemasukanTemp = 0;
      double totalPengeluaranTemp = 0;

      for (var transaction in transactions) {
        // Filter transaksi yang ctypeid == 1 atau type_transaksi == Pemasukan
        if (transaction.ctypeid == '1' ||
            transaction.ctypeTransaksi == 'Pemasukan') {
          totalPemasukanTemp += double.parse(transaction.camount);
        } else if (transaction.ctypeid == '2' ||
            transaction.ctypeTransaksi == 'Pengeluaran') {
          totalPengeluaranTemp += double.parse(transaction.camount);
        }
      }

      setState(() {
        totalPemasukan = totalPemasukanTemp;
        totalPengeluaran = totalPengeluaranTemp;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth * 0.9;

    double selisih = totalPemasukan - totalPengeluaran;
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
        width: contentWidth,
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
                    '+ ${cData.addDotToNumber(totalPemasukan.toStringAsFixed(0))}',
                    style: TextStyle(color: succesColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.05,
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
                    '- ${cData.addDotToNumber(totalPengeluaran.toStringAsFixed(0))}',
                    style: TextStyle(color: errorColor),
                  ),
                  // Tampilkan jumlah pengeluaran di sini
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.05,
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
                    '${cData.addDotToNumber(selisih.toStringAsFixed(0))}',
                    style: selisih >= 0
                        ? TextStyle(color: succesColor)
                        : TextStyle(color: errorColor),
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
