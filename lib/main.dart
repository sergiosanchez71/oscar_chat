import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oscar_chat/config/theme/app_theme.dart';
import 'package:oscar_chat/presentation/screens/chat/chat_screen.dart';
import 'package:oscar_chat/presentation/providers/chat_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
          title: 'Chatea con Óscar',
          debugShowCheckedModeBanner: false,
          theme: AppTheme(selectedColor: 0).theme(),
          home: const ChatScreen()
          ),
    );
  }
}
