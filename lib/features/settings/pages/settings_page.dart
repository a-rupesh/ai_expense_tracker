<<<<<<< HEAD
import 'package:ai_expense_tracker/core/services/pdf_services.dart';
import 'package:ai_expense_tracker/core/theme/theme_service.dart';
import 'package:ai_expense_tracker/features/expenses/viewmodels/expense_viewmodel.dart';
import 'package:ai_expense_tracker/features/pdf/models/pdf_report.dart';
import 'package:ai_expense_tracker/features/settings/widgets/settings_section.dart';
import 'package:ai_expense_tracker/features/settings/widgets/settings_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ExpenseViewModel expenseVM = ExpenseViewModel();
  final PdfService pdfService = PdfService();

  Future<Map<String, dynamic>> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return {};
    }

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    return doc.data() ?? {};
  }

  Future<void> _exportPdf() async {
    try {
      final profile = await _loadProfile();

      final userName = profile["name"] ?? "User";

      final budget = await expenseVM.getBudget();
      final spent = await expenseVM.getTotalSpent();
      final categories = await expenseVM.getCategoryTotals();
      final expenses = await expenseVM.getAllExpenses();

      final report = PdfReport(
        userName: userName,
        budget: budget,
        spent: spent,
        categories: categories,
        recentExpenses: expenses,
        aiInsights: const [],
      );

      final pdf = await pdfService.generateReport(
        report: report,
      );

      if (!mounted) return;

      await Printing.layoutPdf(
        onLayout: (_) async => pdf,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to generate PDF.\n$e",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadProfile(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Unable to load profile.\n\n${snapshot.error}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final data = snapshot.data ?? {};

          final name = data["name"] ?? "User";

          final email =
              FirebaseAuth.instance.currentUser?.email ?? "";

          return ListView(
            padding: const EdgeInsets.all(20),

            children: [

              // ================= PROFILE =================

              SettingsSection(
                title: "Profile",
                children: [
                  SettingsTile(
                    icon: Icons.person_outline,
                    title: name.toString(),
                    subtitle: email,
                  ),
                ],
              ),

              // ================= APPEARANCE =================

              SettingsSection(
                title: "Appearance",
                children: [

                  RadioListTile<ThemeMode>(
                    title: const Text("System"),
                    value: ThemeMode.system,
                    groupValue: themeService.themeMode,

                    onChanged: (mode) {
                      if (mode != null) {
                        themeService.setTheme(mode);
                      }
                    },
                  ),

                  RadioListTile<ThemeMode>(
                    title: const Text("Light"),
                    value: ThemeMode.light,
                    groupValue: themeService.themeMode,

                    onChanged: (mode) {
                      if (mode != null) {
                        themeService.setTheme(mode);
                      }
                    },
                  ),

                  RadioListTile<ThemeMode>(
                    title: const Text("Dark"),
                    value: ThemeMode.dark,
                    groupValue: themeService.themeMode,

                    onChanged: (mode) {
                      if (mode != null) {
                        themeService.setTheme(mode);
                      }
                    },
                  ),
                ],
              ),

              // ================= DATA & EXPORT =================

              SettingsSection(
                title: "Data & Export",
                children: [
                  SettingsTile(
                    icon: Icons.picture_as_pdf_outlined,
                    title: "Export PDF",
                    subtitle: "Generate expense report",
                    onTap: _exportPdf,
                  ),
                ],
              ),

              // ================= ABOUT =================

              SettingsSection(
                title: "About",
                children: const [

                  SettingsTile(
                    icon: Icons.smart_toy_outlined,
                    title: "FinMate AI",
                    subtitle: "Version 1.0.0",
                  ),

                  Divider(height: 1),

                  SettingsTile(
                    icon: Icons.flutter_dash,
                    title: "Built With",
                    subtitle: "Flutter • Firebase • Gemini AI",
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ================= LOGOUT =================

              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(55),
                ),

                icon: const Icon(Icons.logout),

                label: const Text("Logout"),

                onPressed: () async {
                  final logout = await showDialog<bool>(
                    context: context,

                    builder: (_) {
                      return AlertDialog(
                        title: const Text("Logout"),

                        content: const Text(
                          "Are you sure you want to logout?",
                        ),

                        actions: [

                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text("Cancel"),
                          ),

                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    },
                  );

                  if (logout != true) return;

                  await FirebaseAuth.instance.signOut();

                  if (!context.mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/login",
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
=======

import 'package:ai_expense_tracker/core/services/pdf_services.dart';
import 'package:ai_expense_tracker/core/theme/theme_service.dart';
import 'package:ai_expense_tracker/features/expenses/viewmodels/expense_viewmodel.dart';
import 'package:ai_expense_tracker/features/pdf/models/pdf_report.dart';
import 'package:ai_expense_tracker/features/settings/widgets/settings_section.dart';
import 'package:ai_expense_tracker/features/settings/widgets/settings_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ExpenseViewModel expenseVM = ExpenseViewModel();
  final PdfService pdfService = PdfService();

  Future<Map<String, dynamic>> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return {};
    }

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    return doc.data() ?? {};
  }

  Future<void> _exportPdf() async {
    try {
      final profile = await _loadProfile();

      final userName = profile["name"] ?? "User";

      final budget = await expenseVM.getBudget();
      final spent = await expenseVM.getTotalSpent();
      final categories = await expenseVM.getCategoryTotals();
      final expenses = await expenseVM.getAllExpenses();

      final report = PdfReport(
        userName: userName,
        budget: budget,
        spent: spent,
        categories: categories,
        recentExpenses: expenses,
        aiInsights: const [],
      );

      final pdf = await pdfService.generateReport(
        report: report,
      );

      if (!mounted) return;

      await Printing.layoutPdf(
        onLayout: (_) async => pdf,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to generate PDF.\n$e",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadProfile(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Unable to load profile.\n\n${snapshot.error}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final data = snapshot.data ?? {};

          final name = data["name"] ?? "User";

          final email =
              FirebaseAuth.instance.currentUser?.email ?? "";

          return ListView(
            padding: const EdgeInsets.all(20),

            children: [

              // ================= PROFILE =================

              SettingsSection(
                title: "Profile",
                children: [
                  SettingsTile(
                    icon: Icons.person_outline,
                    title: name.toString(),
                    subtitle: email,
                  ),
                ],
              ),

              // ================= APPEARANCE =================

              SettingsSection(
                title: "Appearance",
                children: [

                  RadioListTile<ThemeMode>(
                    title: const Text("System"),
                    value: ThemeMode.system,
                    groupValue: themeService.themeMode,

                    onChanged: (mode) {
                      if (mode != null) {
                        themeService.setTheme(mode);
                      }
                    },
                  ),

                  RadioListTile<ThemeMode>(
                    title: const Text("Light"),
                    value: ThemeMode.light,
                    groupValue: themeService.themeMode,

                    onChanged: (mode) {
                      if (mode != null) {
                        themeService.setTheme(mode);
                      }
                    },
                  ),

                  RadioListTile<ThemeMode>(
                    title: const Text("Dark"),
                    value: ThemeMode.dark,
                    groupValue: themeService.themeMode,

                    onChanged: (mode) {
                      if (mode != null) {
                        themeService.setTheme(mode);
                      }
                    },
                  ),
                ],
              ),

              // ================= DATA & EXPORT =================

              SettingsSection(
                title: "Data & Export",
                children: [
                  SettingsTile(
                    icon: Icons.picture_as_pdf_outlined,
                    title: "Export PDF",
                    subtitle: "Generate expense report",
                    onTap: _exportPdf,
                  ),
                ],
              ),

              // ================= ABOUT =================

              SettingsSection(
                title: "About",
                children: const [

                  SettingsTile(
                    icon: Icons.smart_toy_outlined,
                    title: "FinMate AI",
                    subtitle: "Version 1.0.0",
                  ),

                  Divider(height: 1),

                  SettingsTile(
                    icon: Icons.flutter_dash,
                    title: "Built With",
                    subtitle: "Flutter • Firebase • Gemini AI",
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ================= LOGOUT =================

              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(55),
                ),

                icon: const Icon(Icons.logout),

                label: const Text("Logout"),

                onPressed: () async {
                  final logout = await showDialog<bool>(
                    context: context,

                    builder: (_) {
                      return AlertDialog(
                        title: const Text("Logout"),

                        content: const Text(
                          "Are you sure you want to logout?",
                        ),

                        actions: [

                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text("Cancel"),
                          ),

                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    },
                  );

                  if (logout != true) return;

                  await FirebaseAuth.instance.signOut();

                  if (!context.mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/login",
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
