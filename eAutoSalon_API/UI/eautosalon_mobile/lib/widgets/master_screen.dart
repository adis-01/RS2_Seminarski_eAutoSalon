

import 'package:eautosalon_mobile/screens/login_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget body;
  const MyAppBar({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: [
          IconButton(onPressed: (){
            MyDialogs.showQuestion(context, 'Da li ste sigurni da se želite odjaviti?', () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
             });
          }, icon: const Icon(Icons.logout, size: 20, color: Colors.white,))
        ],
        title: Text(title.toUpperCase(), 
        style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400,letterSpacing: 1.5),),
      ),
      body: body,
    );
  }
}