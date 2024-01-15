// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _passwordActive = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock, size: 60, color: Colors.black87),
              const SizedBox(height: 10),
              const Text("Dobrodošli, unesite kredencijale i prijavite se",
                        style: TextStyle(fontSize: 17, color: Colors.blueGrey,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              const Divider(thickness: 0.2, color: Colors.blueGrey, endIndent: 25, indent: 25),
              const SizedBox(height: 15),
              buildUsername(),
              const SizedBox(height: 20),
              buildPassword(),
              const SizedBox(height: 15),
              const Divider(thickness: 0.2, color: Colors.blueGrey, endIndent: 25, indent: 25),
              const SizedBox(height: 15),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                color: const Color(0xFF248BD6),
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                onPressed: () async{
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  login(username,password);
                },
                child: const Text("Prijavi se", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      )
    );
  }

  SizedBox buildUsername() {
    return SizedBox(
              width: 350,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                 contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  labelText: 'Username',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                  suffixIcon: const Icon(Icons.person, color: Colors.black54)
                ),
              ),
            );
  }

  SizedBox buildPassword() {
    return SizedBox(
              width: 350,
              child: TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  labelText: 'Password',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                  suffixIcon: !_passwordActive ? 
                          const Icon(Icons.key, color: Colors.black54)
                          : IconButton(
                            onPressed: (){
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                          }, icon: _obscureText ? const Icon(Icons.visibility_off, color: Colors.black54,) 
                                                : const Icon(Icons.visibility, color: Colors.black54))
                ),
                onChanged: (value){
                 setState(() {
                   _passwordActive = value.isNotEmpty;
                 });
                },
              ),
            );
  }

  Future<void> login(String username, String password) async{
    Authorization.username = username;
    Authorization.password = password;
    try {
      var data = await _userProvider.fetchData();
      Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HomePageScreen()));
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }

}