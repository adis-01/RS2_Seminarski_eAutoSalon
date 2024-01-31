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
                const Text("EAUTOSALON", style: TextStyle(color: Colors.black54, letterSpacing: 1.5, fontSize: 18, fontWeight: FontWeight.w400),),
                const SizedBox(height: 10),
                Image.asset("assets/images/car_icon.png", width: 180, height: 110,),
                const SizedBox(height: 20),
                const Text("Vozila koja oslikavaju vašu ličnost", style: TextStyle(color: Colors.black87, letterSpacing: 1, fontSize: 16, fontWeight: FontWeight.w500),),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Colors.white
                    ),
                    child: const Icon(Icons.arrow_forward, color: Colors.black87, size: 30,),
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
