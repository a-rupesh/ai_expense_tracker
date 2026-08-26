<<<<<<< HEAD
import 'package:flutter/material.dart';

import '../../../services/gemini_service.dart';
import '../../expenses/viewmodels/expense_viewmodel.dart';
import '../models/chat_message.dart';

class AIChatViewModel extends ChangeNotifier {
  final GeminiService _gemini = GeminiService();
  final ExpenseViewModel _expenseVM = ExpenseViewModel();

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  bool _loading = false;

  bool get loading => _loading;

  AIChatViewModel() {
    _messages.add(
      ChatMessage(
        message:
            "Hello 👋 I'm FinMate AI.\n\nAsk me anything about your expenses.",
        isUser: false,
      ),
    );
  }

  Future<void> sendMessage(String question) async {
    if (question.trim().isEmpty) return;

    _messages.add(
      ChatMessage(
        message: question,
        isUser: true,
      ),
    );

    _loading = true;
    notifyListeners();

    try {
      final expenses = await _expenseVM.getAllExpenses();
      final budget = await _expenseVM.getBudget();

      final reply = await _gemini.askQuestion(
        question,
        expenses,
        budget,
      );

      _messages.add(
        ChatMessage(
          message: reply,
          isUser: false,
        ),
      );
    } catch (e) {
      _messages.add(
        ChatMessage(
          message: "Error: $e",
          isUser: false,
        ),
      );
    }

    _loading = false;
    notifyListeners();
  }
=======
import 'package:flutter/material.dart';

import '../../../services/gemini_service.dart';
import '../../expenses/viewmodels/expense_viewmodel.dart';
import '../models/chat_message.dart';

class AIChatViewModel extends ChangeNotifier {
  final GeminiService _gemini = GeminiService();
  final ExpenseViewModel _expenseVM = ExpenseViewModel();

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  bool _loading = false;

  bool get loading => _loading;

  AIChatViewModel() {
    _messages.add(
      ChatMessage(
        message:
            "Hello 👋 I'm FinMate AI.\n\nAsk me anything about your expenses.",
        isUser: false,
      ),
    );
  }

  Future<void> sendMessage(String question) async {
    if (question.trim().isEmpty) return;

    _messages.add(
      ChatMessage(
        message: question,
        isUser: true,
      ),
    );

    _loading = true;
    notifyListeners();

    try {
      final expenses = await _expenseVM.getAllExpenses();
      final budget = await _expenseVM.getBudget();

      final reply = await _gemini.askQuestion(
        question,
        expenses,
        budget,
      );

      _messages.add(
        ChatMessage(
          message: reply,
          isUser: false,
        ),
      );
    } catch (e) {
      _messages.add(
        ChatMessage(
          message: "Error: $e",
          isUser: false,
        ),
      );
    }

    _loading = false;
    notifyListeners();
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}