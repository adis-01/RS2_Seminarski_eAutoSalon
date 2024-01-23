import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Korisnik', 
    body: Center(
      child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("UREĐIVANJE PODATAKA", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, letterSpacing: 1, fontSize: 16),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: TextField(
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    hintText: 'Ime',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black38)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: TextField(
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    hintText: 'Prezime',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black38)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: TextField(
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black38)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: TextField(
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    hintText: 'Mail',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black38)
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
    
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black87
                  ),
                  child: const Text("SAČUVAJ", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.5, fontSize: 15),),
                ),
              )
            ],
          ),
      ),
    )
    );
  }
}
