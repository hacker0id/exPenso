// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:expenso/data/expense_data.dart';
import 'package:expenso/screens/MainPage.dart';
import 'package:expenso/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sp;
void main() async {
  // * Init Hive
  await Hive.initFlutter();

  // * Open Hive Box (DB)
  await Hive.openBox("expense_db");

// * SharedPrefs
  sp = await SharedPreferences.getInstance();
  runApp(const Expenso());
}

late var device;
bool isLogin = sp.getBool('isLogin') ?? false;

class Expenso extends StatelessWidget {
  const Expenso({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLogin ? const MainPage() : const SplashScreen(),
      ),
    );
  }
}
