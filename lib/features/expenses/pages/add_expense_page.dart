import 'package:flutter/material.dart';
import 'package:ai_expense_tracker/features/expenses/models/expense.dart';
import '../viewmodels/expense_viewmodel.dart';

class AddExpensePage extends StatefulWidget {
  final Expense? expense;

  /// Auto-filled values from Receipt Scanner
  final double? amount;
  final String? category;
  final String? note;
  final DateTime? date;

  const AddExpensePage({
    super.key,
    this.expense,
    this.amount,
    this.category,
    this.note,
    this.date,
  });

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();

  final ExpenseViewModel _viewModel = ExpenseViewModel();

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    /// Edit Expense
    if (widget.expense != null) {
      _amountController.text = widget.expense!.amount.toString();
      _categoryController.text = widget.expense!.category;
      _noteController.text = widget.expense!.note;
      return;
    }

    /// Auto-filled from Receipt Scanner
    if (widget.amount != null) {
      _amountController.text = widget.amount!.toStringAsFixed(2);
    }

    if (widget.category != null) {
      _categoryController.text = widget.category!;
    }

    if (widget.note != null) {
      _noteController.text = widget.note!;
    }

    selectedDate = widget.date;
  }

  Future<void> _saveExpense() async {
    try {
      final amount = double.parse(_amountController.text.trim());

      if (widget.expense == null) {
        await _viewModel.saveExpense(
          amount: amount,
          category: _categoryController.text.trim(),
          note: _noteController.text.trim(),
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense Added Successfully"),
          ),
        );
      } else {
        await _viewModel.updateExpense(
          expenseId: widget.expense!.id,
          amount: amount,
          category: _categoryController.text.trim(),
          note: _noteController.text.trim(),
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense Updated Successfully"),
          ),
        );
      }

      _amountController.clear();
      _categoryController.clear();
      _noteController.clear();

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expense != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Expense" : "Add Expense",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Amount",
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Note",
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
            ),

            if (selectedDate != null) ...[
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 10),
                    Text(
                      "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _saveExpense,
                icon: Icon(
                  isEditing ? Icons.edit : Icons.save,
                ),
                label: Text(
                  isEditing ? "Update Expense" : "Save Expense",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}