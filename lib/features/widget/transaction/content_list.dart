import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/Provider/date_provider.dart';
import 'package:proj_passion_shoot/features/bloc/transaction_bloc.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/data/model/transaction/transaction.dart';
import 'package:provider/provider.dart';

class ContentList extends StatefulWidget {
  const ContentList({super.key});

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  void refreshData() {
    final DateProvider dateProvider =
        Provider.of<DateProvider>(context, listen: false);
    context
        .read<TransactionBloc>()
        .add(LoadTransactionsForDate(dateProvider.selectedDateString));
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final DateProvider dateProvider = Provider.of<DateProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth * 0.9; // 90% dari lebar layar

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(9),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: contentWidth,
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            List<Transaksi> isiData = state.transaksis;
            return ListView.builder(
              itemCount: isiData.length,
              itemBuilder: (context, index) {
                final Transaksi data = isiData[index];
                return ListTile(
                  title: Text(
                    data.title,
                    style: primaryTextStyle,
                  ),
                  subtitle: Text(
                    data.description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Text(
                    '${data.typeid == 1 ? '+' : '-'} ${addDotToNumber(data.amount)}',
                    style: primaryTextStyle.copyWith(
                      color: data.typeid == 1 ? Colors.green : Colors.red,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            );
          } else if (state is TransactionEror) {
            return Center(child: Text(state.error));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  String addDotToNumber(double number) {
    return number.toStringAsFixed(2).replaceAll('.', ',');
  }
}
