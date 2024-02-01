import 'package:expenso/data/hive_database.dart';
import 'package:expenso/models/expense_item.dart';
import 'package:expenso/date_time/date_time_helper.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
//..

//*  List of all Expenses

  List<ExpenseItem> overallExpenseList = [];

//*  Push Expense List

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

// * Prepare Data To Display On App Opening
  final db = HiveDataBase();
  void prepareData() {
    // ^ If Data Exists, pull it

    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

//*  Add New Expense

  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveDataToHive(overallExpenseList);
  }

//*  Delete Expense

  void deleteExpense(ExpenseItem newExpense) {
    overallExpenseList.remove(newExpense);
    notifyListeners();
    db.saveDataToHive(overallExpenseList);
  }

//*  Get Weekday (Mon, Tues, etc) froma dateTime object.
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

//* Get the date for the start of the week ( We will keep it Sunday )

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //& Get Today's Date
    DateTime today = DateTime.now();

    //& Traverse back to find Sunday

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

/*

Convert overall list of Expenses into a daily Expense Summary,
Ex:

overallExpenseList = 

[

[ food , 2023/01/30, $10 ],
[ hat , 2023/01/30, $20 ],
[ drinks , 2023/02/30, $5 ],
[ food , 2023/02/30, $4 ],
[ food , 2023/03/30, $8 ],

]

-> 

DailyExpenseSummary =
[
  [  2023/01/30, $30 ],
  [ 2023/02/30, $9 ],
  [  2023/03/30, $8 ],
]

*/

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.expenseDateTime);
      double amount = double.parse(expense.expenseAmount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
