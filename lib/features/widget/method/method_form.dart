import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/features/data/Payment/addpayment.dart';
import 'package:proj_passion_shoot/api/server-api/apiservices.dart';
import 'package:proj_passion_shoot/features/data/Payment/bank_account.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class MethodForm extends StatefulWidget {
  const MethodForm({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  _MethodFormState createState() => _MethodFormState();
}

class _MethodFormState extends State<MethodForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final Service _service = Service(); // Membuat instance dari Service

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  Future<void> _simpanData() async {
    if (_formKey.currentState!.validate()) {
      final namamethod = _namaController.text;

      try {
        // Ambil data metode pembayaran yang sudah ada dari database
        List<acData> existingMethods = await _service.getmethodpayment();

        // Periksa apakah data yang dimasukkan sudah ada dalam data yang sudah ada,
        // tanpa memperhatikan perbedaan huruf besar atau kecil
        bool exists = existingMethods.any((method) =>
            method.cmethod.toLowerCase() == namamethod.toLowerCase());

        if (exists) {
          // Jika sudah ada, tampilkan peringatan
          _tampilkanDialogDuplikasi();
        } else {
          // Jika belum ada, simpan data
          AddPaymentMethod metodePembayaranBaru =
              AddPaymentMethod(method: namamethod);

          try {
            await _service.savePaymentMethod(metodePembayaranBaru);
            _tampilkanDialogBerhasil();
          } catch (e) {
            // Tangani kesalahan saat menyimpan data
            print('Error menyimpan metode pembayaran: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal menyimpan metode pembayaran: $e'),
              ),
            );
          }
        }
      } catch (e) {
        // Tangani kesalahan saat mengambil data dari database
        print('Error mengambil metode pembayaran: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil metode pembayaran: $e'),
          ),
        );
      }
    }
  }

  void _tampilkanDialogDuplikasi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Metode pembayaran sudah ada!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _tampilkanDialogBerhasil() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Berhasil'),
          content: Text('Metode pembayaran berhasil disimpan!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(Duration(seconds: 0), () {
                  Navigator.of(context).pop();
                  widget.onPressed(); // Panggil balik ke parent
                  _navigateToDestinationPage(
                      context); // Navigasi ke halaman tujuan
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToDestinationPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/_HomeScreenState');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 12),
          TextFormField(
            controller: _namaController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              hintText: 'Nama Sumber Dana',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field ini harus diisi';
              }
              return null;
            },
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
              onPressed: _simpanData,
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
}
