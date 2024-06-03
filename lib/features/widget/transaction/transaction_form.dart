// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/core/api_service.dart';

import 'package:proj_passion_shoot/features/data/model/payment/get_payment_method.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/post_transaction.dart';

// ignore: must_be_immutable
class TransactionForm extends StatefulWidget {
  DateTime selectedDate;
  final int selectedTypeId;
  final dynamic selectedValue;

  TransactionForm({
    super.key,
    required this.selectedDate,
    required this.selectedTypeId,
    this.selectedValue,
  });

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Service serviceAPI = Service();
  late Future<List<PaymentData>> listPayment;
  PaymentData? selectedPayment;

  @override
  void initState() {
    super.initState();
    listPayment = serviceAPI.getmethodpayment();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Date Picker
          TextFormField(
            controller: dateController,
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
                  // Set selected date to the text field
                  dateController.text = DateFormat.yMMMd().format(dateTime);
                });
              }
            },
          ),
          const SizedBox(height: 6),

          // Dropdown untuk Sumber Dana
          FutureBuilder<List<PaymentData>>(
            future: listPayment,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No data available');
              } else {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: const EdgeInsets.all(9),
                  child: DropdownButtonFormField<PaymentData>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sumber Dana',
                    ),
                    items: snapshot.data!.map((PaymentData item) {
                      return DropdownMenuItem<PaymentData>(
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
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 6),

          // Jumlah
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

          // Judul
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

          // Keterangan
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

          // Tombol Simpan
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

  // Function untuk menyimpan transaksi yang diinputkan
  void saveTransaction() async {
    if (selectedPayment != null) {
      try {
        double amount = double.parse(jumlahController.text);
        String title = judulController.text;
        String description = keteranganController.text;

        Transaction transaction = Transaction(
          typeid: widget.selectedTypeId, // Gunakan typeid yang diterima
          paymentid: int.parse(selectedPayment!.cid),
          amount: amount,
          title: title,
          description: description,
          date: DateFormat.yMMMd().format(
              widget.selectedDate), // Menggunakan string dari selectedDate
        );

        print(transaction);
        await serviceAPI.saveTransaction(transaction);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaksi berhasil disimpan!'),
          ),
        );

        // Tampilkan popup berhasil menambahkan
        _showSuccessDialog();
      } catch (e) {
        print('Gagal menyimpan transaksi: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan transaksi: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih sumber dana terlebih dahulu!'),
        ),
      );
    }
  }

  // Method untuk menampilkan dialog berhasil menambahkan
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Transaksi berhasil ditambahkan!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
}
