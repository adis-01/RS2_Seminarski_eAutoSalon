import 'package:eautosalon_admin/utils/util.dart';
import 'package:flutter/material.dart';

import 'home_page_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
              boxShadow: const [
                BoxShadow(
                  color: Colors.blueGrey,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(2,0),
                )
              ]
            ),
            child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Icon(Icons.lock,
                  size: 70,
                  color: Color(0xFF248BD6)
                  ),
                  const SizedBox(height: 10),
                  const Text('Dobrodošli, unesite svoje kredencijale i prijavite se',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey
                  ),
                  ),
                  const SizedBox(height: 25),
                   SizedBox(
                    width: 320,
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 320,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.key),
                        suffix: IconButton(
                          color: Colors.black,
                          icon: _obscureText ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                          onPressed: (){
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          }, 
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.deepPurple, thickness: 0.2, indent: 20, endIndent: 20),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 50),
                      backgroundColor: const Color(0xFF248BD6),
                    ),
                    onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    try {
                      Authorization.username=username;
                      Authorization.password=password;
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => const HomePageScreen()));
                    } catch (e) {
                      throw Exception('Error $e');
                    }
                  }, child: const Text(
                    'Prijavi se',
                    style: TextStyle(fontSize: 15),
                  )
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}