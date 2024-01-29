import 'package:eautosalon_mobile/widgets/mail_dialog.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'KONTAKT',
        body: SingleChildScrollView(
          child: 
           Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.mail, size: 90, color: Colors.white,),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: (){
                          showDialog(
                            context: context, builder: (context) => const MailDialog()
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black87
                          ),
                          child: const Text("POŠALJITE MAIL", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 2),),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Icon(
                  Icons.location_pin,
                  size: 40,
                  color: Colors.black87,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Opine bb, Mostar 88000",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 17,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 25),
                const Icon(
                  Icons.phone_android,
                  size: 40,
                  color: Colors.black87,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "+387387387",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 17,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 25),
                const Icon(
                  Icons.access_time_outlined,
                  size: 40,
                  color: Colors.black87,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Ponedjeljak - petak",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                const Text(
                  "08:00 - 16:00",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
        ));
  }
}
