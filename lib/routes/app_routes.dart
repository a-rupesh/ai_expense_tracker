import 'package:ai_expense_tracker/features/expenses/pages/expense_list_page.dart';
import 'package:ai_expense_tracker/features/receipt_scanner/models/receipt_data.dart';
import 'package:ai_expense_tracker/features/receipt_scanner/pages/receipt_scanner_page.dart';
import 'package:flutter/material.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/register_page.dart';
import '../features/home/home_page.dart';
import '../features/expenses/pages/add_expense_page.dart';
import '../features/ai/pages/ai_chat_page.dart';
import '../features/analytics/pages/analytics_page.dart';
import '../features/settings/pages/settings_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const addExpense = '/add-expense';
  static const expenses = '/expenses';
  static const aiChat = "/ai-chat";
  static const analytics = '/analytics';
  static const receiptScanner = "/receipt-scanner";
  static const settings = "/settings";
  static final routes = <String, WidgetBuilder>{
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    home: (_) => HomePage(),
    addExpense: (context) {
      final receipt =
          ModalRoute.of(context)!.settings.arguments as ReceiptData?;

      return AddExpensePage(
        amount: receipt?.amount,
        category: receipt?.category,
        note: receipt?.merchant,
        date: receipt?.parsedDate,
      );
    },
    expenses: (_) => const ExpenseListPage(),
    aiChat: (_) => const AIChatPage(),
    analytics: (_) => AnalyticsPage(),
    receiptScanner: (_) => const ReceiptScannerPage(),
    settings: (_) => const SettingsPage(),
  };
}
