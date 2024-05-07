import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

// ignore: must_be_immutable
class TransactionForm extends StatefulWidget {
  TransactionForm({
    super.key,
    required this.selectedDate,
    required this.selectedValue,
    required this.onPressed,
  });

  DateTime selectedDate;
  dynamic selectedValue;
  final Function() onPressed;

  @override
  State<TransactionForm> createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {
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
            // enabled: false,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                fillColor: textColor),
            onTap: () async {
              final dateTime = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2200),
              );
              if (dateTime != null) {
                setState(() {
                  widget.selectedDate = dateTime;
                });
              }
            },
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.all(9),
            child: DropdownButton(
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down_rounded),
              iconSize: 30,
              hint: const Text('Sumber Dana'),
              dropdownColor: bgColor,
              isExpanded: true,
              borderRadius: BorderRadius.circular(9),
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
              items: const [
                DropdownMenuItem(
                  value: 'Uang Tunai',
                  child: Text('Uang Tunai'),
                ),
                DropdownMenuItem(
                  value: 'Mandiri',
                  child: Text('Mandiri'),
                ),
                DropdownMenuItem(
                  value: 'BCA',
                  child: Text('BCA'),
                ),
                DropdownMenuItem(
                  value: 'Dana',
                  child: Text('Dana'),
                ),
              ],
              value: widget.selectedValue,
              onChanged: (value) {
                setState(() {
                  widget.selectedValue = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.attach_money_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                hintText: 'Jumlah'),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                hintText: 'Judul'),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                hintText: 'Keterangan'),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              onPressed: widget.onPressed,
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
