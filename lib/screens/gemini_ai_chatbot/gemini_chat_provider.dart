import 'package:flutter/cupertino.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ogaa/screens/gemini_ai_chatbot/gemini_model.dart';

class GeminiChatProvider extends ChangeNotifier {
  final TextEditingController promptController = TextEditingController();
  static const apiKey = "AIzaSyAFV0R1YC8w9XD_WWaxMMnYa0RGQJYm_bo";
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
  final List<GeminiModelMessage> _messages = [];
  bool _canSendMessage = false;

  List<GeminiModelMessage> get messages => _messages;
  bool get canSendMessage => _canSendMessage;

  void validateInput() {
    _canSendMessage = promptController.text.trim().isNotEmpty;
    notifyListeners();
  }

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<void> sendMessage() async {
    final message = promptController.text.trim();
    if (message.isEmpty) return;

    // Add user message
    _messages.add(
      GeminiModelMessage(
        isPrompt: true,
        message: message,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();

    // Clear the input
    promptController.clear();
    validateInput();

    // Show loading animation
    _isFetching = true;
    notifyListeners();

    // Fetch AI response
    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);

      // Add AI response
      _messages.add(
        GeminiModelMessage(
          isPrompt: false,
          message: response.text ?? "I'm sorry, I couldn't process that.",
          dateTime: DateTime.now(),
        ),
      );
    } catch (e) {
      _messages.add(
        GeminiModelMessage(
          isPrompt: false,
          message: "An error occurred: ${e.toString()}",
          dateTime: DateTime.now(),
        ),
      );
    } finally {
      // Stop loading animation
      _isFetching = false;
      notifyListeners();
    }
  }
}
