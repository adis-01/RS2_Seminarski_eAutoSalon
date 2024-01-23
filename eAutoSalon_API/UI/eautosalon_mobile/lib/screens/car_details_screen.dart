import 'package:eautosalon_mobile/screens/car_accessories_screen.dart';
import 'package:eautosalon_mobile/screens/checkout_screen.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:eautosalon_mobile/widgets/test_drive_picker.dart';
import 'package:flutter/material.dart';

import '../widgets/test_drive_picker.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Detalji',
       body: SingleChildScrollView(
         child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
                ),
                child: const SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Icon(Icons.no_photography),
                ),
              ),
              const SizedBox(height: 15),
              const Text("Renault Megane i8", style: TextStyle(fontSize: 16, color: Colors.black54,fontWeight: FontWeight.bold, letterSpacing: 1.5),),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    buildDetailContainer('Cijena','\$8,445.00'),
                    buildDetailContainer('Godina proizvodnje', '2016'),
                    buildDetailContainer('Pređeni kilometri','235432'),
                    buildDetailContainer('Snaga motora','100KS'),
                    buildDetailContainer('Boja','Siva'),
                    buildDetailContainer('Broj vrata','4'),
                    buildDetailContainer('Broj šasije','AS32B9DNM320MK'),
                    buildDetailContainer('Vrsta goriva','Dizel'),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black87
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.cable_rounded, color: Colors.white, size: 20,),
                        title: const Text("DODATNA OPREMA", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                        trailing: IconButton(
                          color: Colors.white,
                          iconSize: 25,
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const CarAccessories()));
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    color: Colors.grey[600],
                    onPressed: (){
                      showDialog(context: context, builder: (context) => const TestDriveDialog());
                  },
                  child:const Text("TESTNA VOŽNJA", style: TextStyle(color: Colors.white),),),
                  const SizedBox(width: 10),
                  MaterialButton(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    color: Colors.grey[600],
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const CheckoutPage()));
                  },
                  child: const Text("ONLINE PLAĆANJE", style: TextStyle(color: Colors.white),),)
                ],
              )
            ],
          ),
         ),
       )
    );
  }

  Container buildDetailContainer(String naslov, String vrijednost) {
    return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(naslov, style: const TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.w600, letterSpacing: 1),),
                      Text(vrijednost, style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),)
                    ],
                  ),
                );
  }
}