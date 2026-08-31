import 'package:flutter/material.dart';

import '../viewmodels/ai_chat_viewmodel.dart';
import '../widgets/chat_bubble.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final AIChatViewModel viewModel = AIChatViewModel();

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Rebuild the page whenever the ViewModel changes
    viewModel.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    viewModel.removeListener(_refresh);
    controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final question = controller.text.trim();

    if (question.isEmpty) return;

    controller.clear();

    await viewModel.sendMessage(question);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ðŸ¤– FinMate AI"),
        centerTitle: true,
      ),
      body: Column(
        children: [

          /// Chat Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: viewModel.messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  chat: viewModel.messages[index],
                );
              },
            ),
          ),

          if (viewModel.loading)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: CircularProgressIndicator(),
            ),

          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Ask FinMate AI...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),

                const SizedBox(width: 10),

                FloatingActionButton(
                  mini: true,
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
