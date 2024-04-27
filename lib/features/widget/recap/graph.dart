import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class Graph extends StatelessWidget {
  const Graph({
    super.key,
    required this.dataMap,
    required this.colorList,
  });

  final Map<String, double> dataMap;
  final List<Color> colorList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
              '01 Apr 2024 - 30 Apr 2024',
              style: primaryTextStyle,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: PieChart(
            dataMap: dataMap,
            chartType: ChartType.ring,
            // baseChartColor: secondaryColor,
            colorList: colorList,
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          ),
        ),
      ],
    );
  }
}