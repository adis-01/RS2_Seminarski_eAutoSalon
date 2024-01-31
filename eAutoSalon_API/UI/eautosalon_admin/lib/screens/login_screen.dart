// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/news_screen.dart';
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
  bool isLoading = false;

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
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: isLoading ? 
              const Center(child: CircularProgressIndicator())
              :
               Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock, size: 60, color: Colors.black87),
                  const SizedBox(height: 15),
                  const Text("DOBRODOŠLI", style: TextStyle(letterSpacing: 2.5,fontSize: 18, color: Colors.blueGrey,fontWeight: FontWeight.w400)),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white70,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        buildHeader(),
                        const SizedBox(height: 25),
                        buildUsername(),
                        const SizedBox(height: 25),
                        buildPassword(),
                        const SizedBox(height: 18),
                        const Divider(thickness: 0.3, color: Colors.blueGrey, indent: 10, endIndent: 10),
                        const SizedBox(height: 18),
                        buildButton(),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  SizedBox buildButton() {
    return SizedBox(
                      width: 250,
                      height: 42,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.all(15),
                        color: Colors.black54,
                        onPressed: (){
                          String username = _usernameController.text;
                          String password = _passwordController.text;
                          setState(() {
                            isLoading=true;
                          });
                          login(username, password);
                        },
                        child: const Text("PRIJAVI SE", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 2))
                      ),
                    );
  }

  Row buildHeader() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.directions_car_outlined, color: Colors.blueGrey, size: 23,),
                        Text("eAutoSalon", style: TextStyle(fontSize: 16, color: Colors.blueGrey, letterSpacing: 1.5)),
                      ],
                    );
  }

  SizedBox buildUsername() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: _usernameController,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            labelText: 'Username',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54),
            suffixIcon: const Icon(Icons.person, color: Colors.black54)),
      ),
    );
  }

  SizedBox buildPassword() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: _passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            labelText: 'Password',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54),
            suffixIcon: !_passwordActive
                ? const Icon(Icons.key, color: Colors.black54)
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _obscureText
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.black54,
                          )
                        : const Icon(Icons.visibility, color: Colors.black54))),
        onChanged: (value) {
          setState(() {
            _passwordActive = value.isNotEmpty;
          });
        },
      ),
    );
  }

  Future<void> login(String username, String password) async {
    Authorization.username = username;
    Authorization.password = password;
    try {
      var data = await _userProvider.getRoles(username);
      setState(() {
        isLoading=false;
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HomePageScreen()));
    } catch (e) {
      setState(() {
        isLoading=false;
      });
      CustomDialogs.showError(context, e.toString());
    }
  }
}
