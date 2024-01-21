
import 'package:eautosalon_mobile/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock, color: Colors.black87, size: 35,),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        labelText: 'Username',
                        suffixIcon: const Icon(Icons.person, color: Colors.black87,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        labelText: 'Password',
                        suffixIcon: const Icon(Icons.key, color: Colors.black87,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(thickness: 0.3, color: Colors.black87, indent: 20, endIndent: 20),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HomePage()));
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black87
                      ),
                      child: const Text("PRIJAVI SE", style: TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 1.7, fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}