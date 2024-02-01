import 'package:expenso/data/expense_data.dart';
import 'package:expenso/main.dart';
import 'package:expenso/models/expense_item.dart';
import 'package:expenso/widgets/Button.dart';
import 'package:expenso/widgets/InputField.dart';
import 'package:expenso/widgets/components/ExpenseSummary.dart';
import 'package:expenso/widgets/components/ExpenseTile.dart';
import 'package:flutter/material.dart';
import 'package:expenso/helpers/controllers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ////
  @override
  void initState() {
    super.initState();
    sp.setBool('isLogin', true);
    // ^ Prepare Data When App Launches
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // *  Add New Expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                //side: BorderSide(color: Colors.lime.shade700, width: 2),
              ),
              shadowColor: Colors.lime,
              elevation: 10,
              title: const Text(
                'Add New Expense 💰',
                style: TextStyle(fontSize: 18),
              ),
              content: Builder(builder: (context) {
                return SizedBox(
                  //height: device.height * 0.3,
                  width: device.width * 0.8,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    InputField(
                        hintText: 'Name',
                        controller: expenseNameController,
                        type: TextInputType.name),
                    SizedBox(height: device.height * 0.02),
                    InputField(
                      hintText: 'Amount',
                      controller: expenseAmountController,
                      type: TextInputType.number,
                    ),
                    SizedBox(height: device.height * 0.035),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          color: Colors.white,
                          bgColor: Colors.lime,
                          onPressed: save,
                          buttonText: 'Save',
                          height: 0.05,
                          width: 0.25,
                        ),
                        SizedBox(width: device.width * 0.05),
                        Button(
                          bgColor: Colors.red.shade300,
                          color: Colors.white,
                          onPressed: cancel,
                          buttonText: 'Cancel',
                          height: 0.05,
                          width: 0.25,
                        ),
                      ],
                    ),
                  ]),
                );
              }),
            ));
  }

// ! Delete Expenses

  void deleteExpenses(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

//* Clear Input Fields
  void clearInputFields() {
    expenseAmountController.clear();
    expenseNameController.clear();
  }

  void save() {
    // ! Only Save When All Details Given

    if (expenseAmountController.text.isNotEmpty &&
        expenseNameController.text.isNotEmpty) {
      //* Create New ExpenseItem Obj
      ExpenseItem newExpense = ExpenseItem(
          expenseName: expenseNameController.text.trim(),
          expenseAmount: expenseAmountController.text.trim(),
          expenseDateTime: DateTime.now());

//* Reflect on Main Page
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clearInputFields();
  }

  void cancel() {
    Navigator.pop(context);
    clearInputFields();
  }

  @override
  Widget build(BuildContext context) {
    device = MediaQuery.sizeOf(context);
    return Consumer<ExpenseData>(
        builder: ((context, value, child) => Scaffold(
            backgroundColor: Colors.lime.shade600,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: addNewExpense,
              child: const Icon(
                color: Colors.lime,
                FontAwesomeIcons.sackDollar,
                size: 35,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: device.height * 0.05),
              child: ListView(
                children: [
                  //^ Summary
                  ExpenseSummary(startOfTheWeek: value.startOfWeekDate()),
                  SizedBox(height: device.height * 0.05),
                  //^ Expenses (List)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getAllExpenseList().length,
                    itemBuilder: (context, index) => ExpenseTile(
                      name: value.getAllExpenseList()[index].expenseName,
                      amount: value.getAllExpenseList()[index].expenseAmount,
                      dateTime:
                          value.getAllExpenseList()[index].expenseDateTime,
                      onTilePressed: (p0) => deleteExpenses(
                        value.getAllExpenseList()[index],
                      ),
                    ),
                  ),
                ],
              ),
            ))));
  }
}
