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
        backgroundColor: Colors.grey[800],
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "EAUTOSALON",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2.5),
                  ),
                 SizedBox(height: 65),
                  Center(
                      child: Icon(
                    Icons.directions_car,
                    size: 100,
                    color: Colors.white,
                  )),
                  SizedBox(height: 25),
                  Text("VOZILA KOJA OSLIKAVAJU VAŠU LIČNOST", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                ],
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
                },
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 35),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Text("PRIJAVA", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
