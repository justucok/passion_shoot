import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Graph extends StatelessWidget {
  const Graph({
    Key? key,
    required this.dataMap,
    required this.colorList,
  }) : super(key: key);

  final Map<String, double> dataMap;
  final List<Color> colorList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          ringStrokeWidth: 35, // Atur ketebalan cincin sesuai kebutuhan Anda
          chartRadius: MediaQuery.of(context).size.width * 0.4,
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesOutside: false, // Nonaktifkan nilai di chart
            showChartValues: false,
            showChartValuesInPercentage:
                false, // Nonaktifkan presentase di chart
          ),
          colorList: colorList,
          legendOptions: const LegendOptions(showLegends: false),
        ),
        SizedBox(height: 20), // Jarak antara chart dan legend
        SizedBox(
          height: 40 * dataMap.length.toDouble(), // Mengatur tinggi legenda
          child: ListView.builder(
            itemCount: dataMap.length,
            itemBuilder: (context, index) {
              var entry = dataMap.entries.elementAt(index);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 30,
                      color: colorList[index],
                      child: Center(
                        child: Text(
                          '${entry.value.toInt()}%',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      entry.key,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
