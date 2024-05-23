import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/api/apiservices.dart';
import 'package:proj_passion_shoot/api/bank_account.dart';
import 'package:proj_passion_shoot/api/datatransaction.dart';
import 'package:proj_passion_shoot/api/typetransaksi.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm({
    Key? key,
    required this.selectedDate,
    required this.selectedTypeId,
    required this.onPressed,
    required this.getSelectedTypeId,
    required acData selectedValue,
  }) : super(key: key);

  late final DateTime selectedDate;
  final int? selectedTypeId;
  final Function() onPressed;
  final Function(int) getSelectedTypeId;

  @override
  State<TransactionForm> createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  Service serviceAPI = Service();
  late Future<List<acData>> listpayment;
  acData? selectedPayment;

  @override
  void initState() {
    super.initState();
    listpayment = serviceAPI.getmethodpayment();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: TextEditingController(
              text: DateFormat('E, dd MMM yyyy').format(widget.selectedDate),
            ),
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            onTap: () async {
              final dateTime = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2200),
                initialDate: widget.selectedDate,
              );
              if (dateTime != null) {
                setState(() {
                  widget.selectedDate = dateTime;
                });
              }
            },
          ),
          const SizedBox(height: 6),
          FutureBuilder<List<acData>>(
            future: listpayment,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return DropdownButtonFormField<acData>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sumber Dana',
                    ),
                    items: snapshot.data!.map((acData item) {
                      return DropdownMenuItem<acData>(
                        value: item,
                        child: Text(item.cmethod),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPayment = value;
                      });
                    },
                    value: selectedPayment,
                  );
                }
              }
            },
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: jumlahController,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.attach_money_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              hintText: 'Jumlah',
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: judulController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              hintText: 'Judul',
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: keteranganController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              hintText: 'Keterangan',
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              onPressed: () {
                saveTransaction();
              },
              child: Text(
                'Simpan',
                style: secondaryTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getTypeTransaksiById(int id) async {
    try {
      List<typeTransaksiData> type = await Service().getTypeTransaksi();
      typeTransaksiData selectedType =
          type.firstWhere((element) => element.cid == id.toString());
      String ctypeid = selectedType.cid;
      return ctypeid; // Kembalikan ctypeid
    } catch (e) {
      print('Gagal mengambil data jenis transaksi: $e');
      throw e;
    }
  }

  void saveTransaction() async {
    if (selectedPayment != null) {
      try {
        String ctypeid = await getTypeTransaksiById(widget.selectedTypeId ??
            1); // Panggil getTypeTransaksiById dengan parameter yang sesuai
        cData transaction = cData(
          ctypeid: ctypeid,
          cpaymentid: selectedPayment!.cid,
          camount: jumlahController.text,
          ctitle: judulController.text,
          cdescription: keteranganController.text,
          cid: '',
          ctypeTransaksi: '',
          cmethod: '',
        );
        print(transaction);
        serviceAPI.saveTransaction(transaction).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Transaksi berhasil disimpan!'),
            ),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menyimpan transaksi: $error'),
            ),
          );
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan transaksi: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Silakan pilih sumber dana terlebih dahulu!'),
        ),
      );
    }
  }
}
