import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:oscar_chat/config/helpers/get_yes_no_answer.dart';
import 'package:oscar_chat/domain/entities/message.dart';
import 'package:oscar_chat/domain/entities/responses.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: '¡Hola! Mi nombre es Óscar', fromWho: FromWho.his),
    Message(
        text: 'Estoy encantado de hablar contigo, pregúntame lo que quieras',
        fromWho: FromWho.his),
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    moveScrollToBottom();

    for (var responses in responsesList) {
      for (var response in responses) {
        if (text.toLowerCase().contains(response.toLowerCase()) &&
            text.contains('?')) {
          return hisReply(responses, text);
        } else if (text.toLowerCase().contains(response.toLowerCase())) {
          return hisReply(responses, text);
        }
      }
    }

    if (text.contains('?')) {
      return hisReplyYesNo();
    }

    await Future.delayed(const Duration(milliseconds: 1000));
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    moveScrollToBottom();
  }

  Future<void> hisReply(List<String> responses, senderMessage) async {
    bool isQuestion = false;
    for (var response in responses) {
      if (response.contains('?')) {
        isQuestion = true;
      }
    }
    if (!(isQuestion)) {
      Random random = Random();
      int randomList = random.nextInt(responses.length);

      final hisMessage =
          Message(text: responses[randomList], fromWho: FromWho.his);

      messageList.add(hisMessage);

      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));
      moveScrollToBottom();
    } else if (senderMessage.contains('?')) {
      Random random = Random();
      int randomList = random.nextInt(responses.length);

      while (responses[randomList].contains('?')) {
        randomList = random.nextInt(responses.length);
      }

      final hisMessage =
          Message(text: responses[randomList], fromWho: FromWho.his);

      messageList.add(hisMessage);

      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));
      moveScrollToBottom();
    }
  }

  Future<void> hisReplyYesNo() async {
    final hisMessage = await getYesNoAnswer.getAnswer();
    messageList.add(hisMessage);

    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    moveScrollToBottom();
  }

  void moveScrollToBottom() {
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
