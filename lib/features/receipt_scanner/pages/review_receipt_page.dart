import 'package:flutter/material.dart';

import '../models/receipt_data.dart';
import '../../expenses/pages/add_expense_page.dart';

class ReviewReceiptPage extends StatefulWidget {
  final ReceiptData receipt;

  const ReviewReceiptPage({
    super.key,
    required this.receipt,
  });

  @override
  State<ReviewReceiptPage> createState() =>
      _ReviewReceiptPageState();
}

class _ReviewReceiptPageState
    extends State<ReviewReceiptPage> {

  late TextEditingController merchantController;
  late TextEditingController amountController;
  late TextEditingController categoryController;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();

    merchantController =
        TextEditingController(text: widget.receipt.merchant);

    amountController =
        TextEditingController(text: widget.receipt.amount.toString());

    categoryController =
        TextEditingController(text: widget.receipt.category);

    dateController =
        TextEditingController(text: widget.receipt.date);
  }

  @override
  void dispose() {
    merchantController.dispose();
    amountController.dispose();
    categoryController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Widget buildField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(icon),
            labelText: label,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Review Receipt"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Center(
              child: Column(
                children: [

                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Receipt Scanned Successfully",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Review the extracted details before saving.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            buildField(
              icon: Icons.store,
              label: "Merchant",
              controller: merchantController,
            ),

            buildField(
              icon: Icons.currency_rupee,
              label: "Amount",
              controller: amountController,
            ),

            buildField(
              icon: Icons.category,
              label: "Category",
              controller: categoryController,
            ),

            buildField(
              icon: Icons.calendar_month,
              label: "Date",
              controller: dateController,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(

                icon: const Icon(Icons.arrow_forward),

                label: const Text(
                  "Continue to Add Expense",
                ),

                onPressed: () {

                  Navigator.pushReplacement(

                    context,

                    MaterialPageRoute(

                      builder: (_) => AddExpensePage(

                        amount: double.tryParse(
                              amountController.text,
                            ) ??
                            0,

                        category: categoryController.text,

                        note: merchantController.text,

                        date: DateTime.tryParse(
                          dateController.text,
                        ),

                      ),

                    ),

                  );

                },

              ),
            ),

          ],

        ),

      ),

    );
  }
    }