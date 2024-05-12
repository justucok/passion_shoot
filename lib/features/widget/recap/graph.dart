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
      children: [
        // daterange
          Center(
            child: TextButton(
              onPressed: () async {
                final DateTimeRange? dateTimeRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2200));
                if (dateTimeRange != null) {
                  setState(() {
                    selectedDates = dateTimeRange;
                  });
                }
              },
              child: Text(
                "${DateFormat('d MMM yyyy').format(selectedDates.start)} - ${DateFormat('d MMM yyyy').format(selectedDates.end)}",
                style: primaryTextStyle,
              ),
            ),
          ),
          // end daterange
          const SizedBox(
            height: 20,
          ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: PieChart(
            dataMap: widget.dataMap,
            chartType: ChartType.ring,
            // baseChartColor: secondaryColor,
            colorList: widget.colorList,
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
          ),
        ),
      ],
    );
  }
}