import 'package:eautosalon_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("EAUTOSALON", style: TextStyle(color: Colors.black54, letterSpacing: 2, fontSize: 15, fontWeight: FontWeight.w400),),
                const SizedBox(height: 10),
                Image.asset("assets/images/car_icon.png", width: 150, height: 95,),
                const SizedBox(height: 20),
                const Text("Vozila koja oslikavaju vašu ličnost", style: TextStyle(color: Colors.black87, letterSpacing: 1.5, fontSize: 15, fontWeight: FontWeight.w500),),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white70
                    ),
                    child: const Icon(Icons.arrow_forward, color: Colors.black54, size: 35,),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
