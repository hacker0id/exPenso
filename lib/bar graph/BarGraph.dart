import 'package:expenso/bar%20graph/BarData.dart';
import 'package:expenso/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  const BarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    //~ Before Bar Obj Creation, Initialize the Bar Data
    BarData myBarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thuAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        titlesData: const FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

            //* Custom
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles),
            )),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map(
              (e) => BarChartGroupData(
                x: e.x,
                barRods: [
                  BarChartRodData(
                      toY: e.y,
                      color: Colors.grey,
                      width: device.width * 0.05,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY,

                        //! Change background of bar
                        color: Colors.grey.shade100,
                      )),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    height: 0.9,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text('S', style: style);
      break;

    case 1:
      text = const Text('M', style: style);
      break;

    case 2:
      text = const Text('T', style: style);
      break;

    case 3:
      text = const Text('W', style: style);
      break;

    case 4:
      text = const Text('T', style: style);
      break;

    case 5:
      text = const Text('F', style: style);
      break;

    case 6:
      text = const Text('S', style: style);
      break;

    default:
      text = const Text('', style: style);
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
