
import 'package:eautosalon_admin/screens/login_screen.dart';
import 'package:eautosalon_admin/screens/news_insert_screen.dart';
import 'package:eautosalon_admin/screens/news_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:flutter/material.dart';

class EditorMasterScreen extends StatefulWidget {
  String title;
  Widget body;
  bool isHomePage;
  EditorMasterScreen({super.key, required this.title, required this.body, required this.isHomePage});

  @override
  State<EditorMasterScreen> createState() => _EditorMasterScreenState();
}

class _EditorMasterScreenState extends State<EditorMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: widget.isHomePage ?
      Tooltip(
        message: 'Dodaj',
        child: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const InsertNewScreenEditor()));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      )
      : null,
      appBar: AppBar(
        automaticallyImplyLeading: !widget.isHomePage,
        actions: [
          Tooltip(
            message: 'Početna stranica',
            child: MaterialButton(
              padding: const EdgeInsets.all(15),
              shape: const CircleBorder(),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const NewsScreen()));
              },
              child: const Icon(Icons.home, color: Colors.white),
            ),
          ),
          Tooltip(
            message: 'Odjava',
            child: MaterialButton(
              padding: const EdgeInsets.all(15),
              shape: const CircleBorder(),
              onPressed: (){
                CustomDialogs.showQuestion(context, 'Da li ste sigurni da se želite odjaviti?', () { 
                  _logOut();
                });
            },
            child: const Icon(Icons.logout, color: Colors.white)),
          )
        ],
        backgroundColor: Colors.black87,
        toolbarOpacity: 0.7,
        centerTitle: true,
        elevation: 3,
        title: Text(widget.title,
            style: const TextStyle(
                fontSize: 22, letterSpacing: 3.5, fontWeight: FontWeight.w700, color: Colors.white70)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      body: widget.body,
    );
  }

  void _logOut(){
    Authorization.username = "";
    Authorization.password = "";
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
  }


}