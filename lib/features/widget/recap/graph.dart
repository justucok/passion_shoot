import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';

class Graph extends StatefulWidget {
  const Graph({
    super.key,
    required this.dataMap,
    required this.colorList,
  });

  final Map<String, double> dataMap;
  final List<Color> colorList;

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: TextButton(
            onPressed: () async {
              final DateTimeRange? dateTimeRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2200),
              );
              if (dateTimeRange != null) {
                setState(() {
                  selectedDates = dateTimeRange;
                });
              }
            },
            child: Text(
              "${DateFormat('dd MMM yyyy').format(selectedDates.start)} - ${DateFormat('dd MMM yyyy').format(selectedDates.end)}",
              style: primaryTextStyle,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        PieChart(
          dataMap: widget.dataMap,
          chartType: ChartType.ring,
          ringStrokeWidth: 35, // Atur ketebalan cincin sesuai kebutuhan Anda
          chartRadius: MediaQuery.of(context).size.width * 0.4,
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesOutside: false, // Nonaktifkan nilai di chart
            showChartValues: false,
            showChartValuesInPercentage:
                false, // Nonaktifkan presentase di chart
          ),
          colorList: widget.colorList,
          legendOptions: const LegendOptions(showLegends: false),
        ),
        const SizedBox(height: 20), // Jarak antara chart dan legend
        SizedBox(
          height: 40 * widget.dataMap.length.toDouble(), // Mengatur tinggi legenda
          child: ListView.builder(
            itemCount: widget.dataMap.length,
            itemBuilder: (context, index) {
              var entry = widget.dataMap.entries.elementAt(index);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 30,
                      color: widget.colorList[index],
                      child: Center(
                        child: Text(
                          '${entry.value.toInt()}%',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry.key,
                      style: const TextStyle(fontSize: 16),
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
