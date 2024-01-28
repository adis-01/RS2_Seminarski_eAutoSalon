
// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/screens/home_page_screen.dart';
import 'package:eautosalon_mobile/screens/regist_scr.dart';
import 'package:eautosalon_mobile/screens/verif_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;
  late UserProvider _userProvider;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _userProvider=context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: 
           Center(
             child: SingleChildScrollView(
               child: Container(
                padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.lock, color: Colors.grey, size: 80,),
                        const SizedBox(height: 15),
                        const Text("DOBRODOŠLI", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 18),),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                          ),
                          child: TextField(
                            cursorColor: Colors.grey,
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.person, color: Colors.grey,),
                              hintText: 'Username',
                              hintStyle: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w400, fontSize: 14)
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                          ),
                          child: TextField(
                            obscureText: obscureText,
                            cursorColor: Colors.grey,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.key, color: Colors.grey,),
                              hintStyle:const  TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w400, fontSize: 14),
                              suffixIcon: IconButton(
                                onPressed: (){
                                 setState(() {
                                   obscureText = !obscureText;
                                 });
                              }, icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.black87,size: 30,))
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            logIn();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.black87,
                                  Colors.grey
                                ]
                              )
                            ),
                            child: 
                            const Text("PRIJAVA", textAlign: TextAlign.center,style: TextStyle(fontSize: 15, color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.w400),),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Nemate račun?",
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (builder) => const Registration()));
                              },
                              child: const Text("Registrujte se.", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 15 ),),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const VerificationScreen()));
                          },
                          child: const Text("Verifikacija", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 17),),
                        )
                      ],
                    ),
                  ),
             ),
           ),
            ),
    );
  }
  
  Future<void> logIn() async{
    Authorization.username = _usernameController.text;
    Authorization.password = _passwordController.text;
    try {
     var data = await _userProvider.getUserId();
     Authorization.userId = data;
     Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HomePage()));
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
  
}