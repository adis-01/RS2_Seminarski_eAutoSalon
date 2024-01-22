import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
         return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 25,)),
                  const SizedBox(width: 15),
                  const Text(
                    "Kreirajte svoj račun", 
                  style: TextStyle(color: Colors.black87, letterSpacing: 1.2, fontSize: 19, fontWeight: FontWeight.w500)
                  ),
                ]),
                const SizedBox(height: 10),
                //ime
               Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextField(
                    cursorColor: Colors.grey,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black54)
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Ime',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                //prezime
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextField(
                    cursorColor: Colors.grey,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black54)
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Prezime',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                //email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextField(
                    cursorColor: Colors.grey,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black54)
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextField(
                    cursorColor: Colors.grey,
                    obscureText: obscure,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 2)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black54)
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Lozinka',
                      hintStyle: TextStyle(color: Colors.grey[400]),
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
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}


