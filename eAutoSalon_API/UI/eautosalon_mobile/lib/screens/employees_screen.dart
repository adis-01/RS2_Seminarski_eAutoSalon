import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Uposlenici',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              children: [
                const Text(
                  "NAŠ TIM",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 20),
                buildEmployeeCard('Ime','Prezime','CEO','ceo@ups.ba')
              ],
            ),
          ),
        ));
  }

  Container buildEmployeeCard(String firstName, String lastName, String title, String mail) {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //slika
                    const SizedBox(
                      width: double.infinity,
                      height: 140,
                      child: Center(
                          child: Icon(
                        Icons.no_photography,
                        size: 80,
                        color: Colors.black87,
                      )),
                    ),
                    //ime i prezime
                    Text(
                      "$firstName $lastName",
                      style: const TextStyle(
                          color: Colors.black54,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    //pozicija
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          letterSpacing: 1.5),
                    ),
                    const SizedBox(height: 15),
                    //kontakt
                    Row(
                      children: [
                        const Icon(Icons.mail, size: 25, color: Colors.black54,),
                        const SizedBox(width: 8),
                        Text(mail, style: const TextStyle(color: Colors.black87, letterSpacing: 1.4, fontWeight: FontWeight.w400, fontSize: 14),)
                      ],
                    )
                  ],
                ),
              );
  }
}
