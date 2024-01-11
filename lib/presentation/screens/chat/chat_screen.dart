import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oscar_chat/domain/entities/message.dart';
import 'package:oscar_chat/presentation/providers/chat_provider.dart'; 
import 'package:oscar_chat/presentation/widgets/chat/his_message_bubble.dart';
import 'package:oscar_chat/presentation/widgets/chat/my_message_buble.dart';
import 'package:oscar_chat/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://sergiosanchez.site/projects/facepet/controlador/uploads/usuarios/61.png'),
          ),
        ),
        title: const Text('Óscar'),
        centerTitle: false,
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messageList[index];

                      return (message.fromWho == FromWho.his)
                        ? HisMessageBubble(message: message)
                        : MyMessageBubble(message: message);
                    })),

            //Caja de texto de mensajes
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}
