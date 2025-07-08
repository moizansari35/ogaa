class GeminiModelMessage {
  final bool isPrompt;
  final String message;
  final DateTime dateTime;

  GeminiModelMessage({
    required this.isPrompt,
    required this.message,
    required this.dateTime,
  });
}
