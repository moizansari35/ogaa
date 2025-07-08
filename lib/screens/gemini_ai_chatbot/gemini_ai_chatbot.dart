import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ogaa/constants/colors.dart';
import 'package:ogaa/screens/gemini_ai_chatbot/gemini_chat_provider.dart';
import 'package:ogaa/screens/gemini_ai_chatbot/widgets/message_container.dart';
import 'package:ogaa/screens/gemini_ai_chatbot/widgets/three_dots_animation.dart';
import 'package:provider/provider.dart';

class GeminiAiChatbot extends StatelessWidget {
  const GeminiAiChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GeminiChatProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: const Text(
            "OGAA AI Chatbot",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.whiteColor,
            ),
          ),
          centerTitle: true,
        ),
        body: const ChatBody(),
      ),
    );
  }
}

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GeminiChatProvider>(context);
    final promptController = provider.promptController;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: provider.messages.length + (provider.isFetching ? 1 : 0),
            itemBuilder: (context, index) {
              if (provider.isFetching && index == provider.messages.length) {
                // Display loading animation as the last item
                return const ThreeDotsAnimation();
              }

              final message = provider.messages[index];
              return userPrompt(
                isPrompt: message.isPrompt,
                message: message.message,
                time: DateFormat('hh:mm a').format(message.dateTime),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 20,
                child: TextField(
                  controller: promptController,
                  cursorColor: MyColors.primaryColor,
                  style: const TextStyle(
                    fontSize: 20,
                    color: MyColors.blackColor,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter text here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (_) => provider.validateInput(),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: provider.canSendMessage
                    ? () {
                        provider.sendMessage();
                      }
                    : null,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: provider.canSendMessage
                      ? MyColors.primaryColor
                      : Colors.grey,
                  child: const Icon(
                    Icons.send,
                    color: MyColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
