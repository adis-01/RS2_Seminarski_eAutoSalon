import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class PassChange extends StatefulWidget {
  const PassChange({super.key});

  @override
  State<PassChange> createState() => _PassChangeState();
}

class _PassChangeState extends State<PassChange> {

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'LOZINKA', 
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("PROMJENA LOZINKE", style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500, fontSize: 18, letterSpacing: 1),),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: 0.2
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10, horizontal: 5),
                      child: TextField(
                        obscureText: obscure,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white70,
                          hintText: 'Stara lozinka',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: Colors.black54,),
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: TextField(
                        obscureText: obscure,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white70,
                          hintText: 'Nova lozinka',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: Colors.black54,),
                          )
                        ),
                      ),
                    ),
                   Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: TextField(
                        obscureText: obscure,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white70,
                          hintText: 'Ponovite novu lozinku',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: Colors.black54,),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black87
                  ),
                  child: const Text("SAČUVAJ", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}