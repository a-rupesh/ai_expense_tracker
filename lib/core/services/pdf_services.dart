import 'dart:typed_data';

import 'package:ai_expense_tracker/features/pdf/models/pdf_report.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<Uint8List> generateReport({
  required PdfReport report,
}) async {

  final font = pw.Font.ttf(
    await rootBundle.load(
      'lib/assets/fonts/NotoSans-Regular.ttf',
    ),
  );

  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(
      base: font,
      bold: font,
    ),
  );

  final remaining = report.budget - report.spent;

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        margin: const pw.EdgeInsets.all(32),
      ),
      build: (context) => [
        _buildHeader(),
        _buildUserInfo(report),
        pw.SizedBox(height: 20),
        _buildFinancialSummary(
          budget: report.budget,
          spent: report.spent,
          remaining: remaining,
        ),
        pw.SizedBox(height: 20),
        _buildCategoryTable(report.categories),
        pw.SizedBox(height: 20),
        _buildRecentExpenses(report.recentExpenses),
      ],
    ),
  );

  return pdf.save();
}

  //================ HEADER =================//

  pw.Widget _buildHeader() {
    return pw.Column(
      children: [
        pw.Center(
          child: pw.Text(
            "FinMate AI",
            style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.SizedBox(height: 6),
        pw.Center(
          child: pw.Text(
            "Monthly Financial Report",
            style: const pw.TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        pw.Divider(),
      ],
    );
  }

  //================ USER =================//

  pw.Widget _buildUserInfo(PdfReport report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "User",
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Text(report.userName),
      ],
    );
  }

  //================ SUMMARY =================//

  pw.Widget _buildFinancialSummary({
    required double budget,
    required double spent,
    required double remaining,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Financial Summary",
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 18,
          ),
        ),

        pw.SizedBox(height: 10),

        pw.Table(
          border: pw.TableBorder.all(
            color: PdfColors.grey300,
          ),
          children: [
            _row(
              "Budget",
              "â‚¹${budget.toStringAsFixed(2)}",
            ),
            _row(
              "Spent",
              "â‚¹${spent.toStringAsFixed(2)}",
            ),
            _row(
              "Remaining",
              "â‚¹${remaining.toStringAsFixed(2)}",
            ),
          ],
        ),
      ],
    );
  }

  //================ CATEGORY TABLE =================//

  pw.Widget _buildCategoryTable(
    Map<String, double> categories,
  ) {
    final sortedCategories = categories.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Category Breakdown",
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 12),

        pw.Table(
          border: pw.TableBorder.all(
            color: PdfColors.grey300,
          ),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColors.grey200,
              ),
              children: [
                _tableCell(
                  "Category",
                  bold: true,
                ),
                _tableCell(
                  "Amount",
                  bold: true,
                ),
              ],
            ),

            ...sortedCategories.map(
              (entry) => pw.TableRow(
                children: [
                  _tableCell(entry.key),
                  _tableCell(
                    "â‚¹${entry.value.toStringAsFixed(2)}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //================ RECENT EXPENSES =================//

  pw.Widget _buildRecentExpenses(
    List<Map<String, dynamic>> expenses,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Recent Transactions",
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 12),

        pw.Table(
          border: pw.TableBorder.all(
            color: PdfColors.grey300,
          ),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColors.grey200,
              ),
              children: [
                _tableCell(
                  "Category",
                  bold: true,
                ),
                _tableCell(
                  "Note",
                  bold: true,
                ),
                _tableCell(
                  "Amount",
                  bold: true,
                ),
              ],
            ),

            ...expenses.take(10).map(
              (expense) => pw.TableRow(
                children: [
                  _tableCell(
                    expense["category"]?.toString() ?? "",
                  ),
                  _tableCell(
                    expense["note"]?.toString() ?? "",
                  ),
                  _tableCell(
                    "â‚¹${expense["amount"]}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //================ TABLE CELL =================//

  pw.Widget _tableCell(
    String text, {
    bool bold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight:
              bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  //================ SUMMARY ROW =================//

  pw.TableRow _row(
    String left,
    String right,
  ) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(left),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(right),
        ),
      ],
    );
  }
}
