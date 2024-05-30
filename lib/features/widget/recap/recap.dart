import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/datasource/remote_datasouce/api_service.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/get_transaction.dart';
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
  Map<String, double> dataMap = {'Income': 0, 'Expenses': 0, 'Balance': 0};
  List<TransactionData> transactions = [];
  bool isLoading = true;

  final colorList = <Color>[
    succesColor,
    primaryColor,
    dangerColor,
  ];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      final fetchedTransactions = await serviceAPI.getallTransaction();
      double income = 0;
      double expenses = 0;

      for (var transaction in fetchedTransactions) {
        double amount = double.tryParse(transaction.camount) ?? 0;

        if (transaction.ctypeid == '1') {
          income += amount;
        } else if (transaction.ctypeid == '2') {
          expenses += amount;
        }
      }

      double total = income + expenses;
      double balance = income - expenses;

      setState(() {
        transactions = fetchedTransactions;
        dataMap = {
          'Income': (total != 0) ? (income / total) * 100 : 0,
          'Expenses': (total != 0) ? (expenses / total) * 100 : 0,
          'Balance': (total != 0) ? (balance / total) * 100 : 0,
        };
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle error, show error message
      print('Error fetching transactions: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Rekapitulasi',
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // toggle button
                Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  padding: const EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width * 0.9,
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
                          isSelected[i] = i == newIndex;
                        }
                      });
                    },
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.14),
                        child: const Text('Realtime'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.14),
                        child: const Text('Detail'),
                      ),
                    ],
                  ),
                ),
                // end toggle button
                isSelected[0]
                    ? Graph(dataMap: dataMap, colorList: colorList)
                    : DetailList(transactions: transactions),
              ],
            ),
    );
  }
}
