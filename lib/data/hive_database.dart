import 'package:expenso/models/expense_item.dart';
import 'package:hive/hive.dart';

class HiveDataBase {
// * Reference The Box

  final _myBox = Hive.box("expense_db");

// * Write Data

  void saveDataToHive(List<ExpenseItem> allExpenses) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpenses) {
      // & Convert each exp item to a storable type
      List<dynamic> expenseFormatted = [
        expense.expenseName,
        expense.expenseAmount,
        expense.expenseDateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    // &  Store in Db
    _myBox.put("All_Expenses", allExpensesFormatted);
  }

// * Read Data

  List<ExpenseItem> readData() {
    // &  Do Reverse Of Save

    List savedExpenses = _myBox.get("All_Expenses") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      // * Extract Individual Items

      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // * Create back the ExpItem

      ExpenseItem expense = ExpenseItem(
          expenseName: name, expenseAmount: amount, expenseDateTime: dateTime);

      // * Append it to Overall List

      allExpenses.add(expense);
    }

    return allExpenses;
  }
//.
}
