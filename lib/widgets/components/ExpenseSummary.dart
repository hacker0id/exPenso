import 'package:expenso/bar%20graph/BarGraph.dart';
import 'package:expenso/data/expense_data.dart';
import 'package:expenso/date_time/date_time_helper.dart';
import 'package:expenso/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfTheWeek;
  const ExpenseSummary({super.key, required this.startOfTheWeek});

  // ^ Calc Max Amount For Bars

  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    values.sort();
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  // * Calculate Week Total

  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    double total = 0;

    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // *  Get YYYYMMDD For Each Day Of Week

    String sunday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          // * Display Week Total Summary
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Text(
                  'Week Total : ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '\$ ${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: device.height * 0.03),
          SizedBox(
            height: device.height * 0.25,
            child: BarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                  thursday, friday, saturday),
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thuAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
