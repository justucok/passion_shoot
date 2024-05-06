import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';

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
    return SizedBox(
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
    );
  }
}