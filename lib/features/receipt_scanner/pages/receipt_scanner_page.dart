
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/receipt_data.dart';
import '../pages/review_receipt_page.dart';
import '../viewmodels/receipt_scanner_viewmodel.dart';

class ReceiptScannerPage extends StatefulWidget {
  const ReceiptScannerPage({super.key});

  @override
  State<ReceiptScannerPage> createState() => _ReceiptScannerPageState();
}

class _ReceiptScannerPageState extends State<ReceiptScannerPage> {
  final ImagePicker picker = ImagePicker();
  final ReceiptScannerViewModel viewModel = ReceiptScannerViewModel();

  File? image;
  String recognizedText = "";
  ReceiptData? receiptData;

  bool isLoading = false;

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Future<void> pickReceipt() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (picked == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final file = File(picked.path);

      // OCR
      final text = await viewModel.recognizeReceipt(file);

      // AI Analysis
      final receipt = await viewModel.analyzeReceipt(text);

      setState(() {
        image = file;
        recognizedText = text;
        receiptData = receipt;
      });

      if (!mounted) return;

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ReviewReceiptPage(receipt: receipt)),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to scan receipt.\n\n$e")));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Receipt"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child:
                    image == null
                        ? Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: 70,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "No receipt scanned yet",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : Image.file(image!, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),

            if (!isLoading && recognizedText.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recognized Text",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: SelectableText(recognizedText),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : pickReceipt,
                icon: const Icon(Icons.camera_alt),
                label: Text(image == null ? "Scan Receipt" : "Scan Again"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}