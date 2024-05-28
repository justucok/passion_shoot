import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/datasource/remote_datasouce/api_service.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';
import 'package:proj_passion_shoot/features/widget/recap/detail_list.dart';
import 'package:proj_passion_shoot/features/widget/recap/graph.dart';

class RecapContent extends StatefulWidget {
  const RecapContent({
    super.key,
  });

  @override
  State<RecapContent> createState() => _RecapContentState();
}

class _RecapContentState extends State<RecapContent> {
  Service serviceAPI = Service();

  List<bool> isSelected = [true, false];
  final dataMap = <String, double>{
    'Income': 57,
    'Expenses': 25,
    'Balance': 18,
  };

  final colorList = <Color>[
    succesColor,
    primaryColor,
    dangerColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Rekapitulasi',
        ),
      ),
      body: Column(
        children: [
          // toggle button

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            padding: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width *
                0.9, // Menggunakan MediaQuery untuk mendapatkan lebar layar dan menyesuaikan Container
            child: ToggleButtons(
              textStyle: primaryTextStyle,
              splashColor: secondaryColor,
              color: textColor,
              selectedColor: Colors.white,
              fillColor: secondaryColor,
              borderColor: secondaryColor,
              selectedBorderColor: secondaryColor,
              borderRadius: BorderRadius.circular(12),
              isSelected: isSelected,
              onPressed: (int newIndex) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    if (i == newIndex) {
                      isSelected[i] = true;
                      // return Graph(dataMap: dataMap, colorList: colorList);
                    } else {
                      isSelected[i] = false;
                    }
                  }
                });
              },
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          0.14), // Menggunakan MediaQuery untuk mendapatkan lebar layar dan menyesuaikan padding
                  child: const Text('Realtime'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          0.14), // Menggunakan MediaQuery untuk mendapatkan lebar layar dan menyesuaikan padding
                  child: const Text('Detail'),
                ),
              ],
            ),
          ),
          // end toggle button
          isSelected[0]
              ? Graph(dataMap: dataMap, colorList: colorList)
              : const DetailList(),
        ],
      ),
    );
  }
}
