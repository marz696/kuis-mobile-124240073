import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() => runApp(const GacoanApp());

class GacoanApp extends StatelessWidget {
  const GacoanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Uniqlo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}
