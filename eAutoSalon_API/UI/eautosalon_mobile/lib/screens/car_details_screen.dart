import 'package:eautosalon_mobile/screens/car_accessories_screen.dart';
import 'package:eautosalon_mobile/screens/checkout_screen.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:eautosalon_mobile/widgets/test_drive_picker.dart';
import 'package:flutter/material.dart';

import '../models/car.dart';


class CarDetails extends StatefulWidget {
  final Car automobil;
  const CarDetails({super.key, required this.automobil});

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
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
                ),
                child:  SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: widget.automobil.slika == "" ? 
                  const Icon(Icons.no_photography) : fromBase64String(widget.automobil.slika!),
                ),
              ),
              const SizedBox(height: 15),
              Text(widget.automobil.proizvodjacModel ?? "null", style: const TextStyle(fontSize: 16, color: Colors.black54,fontWeight: FontWeight.bold, letterSpacing: 1.5),),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    buildDetailContainer('Cijena',"\$${widget.automobil.formattedPrice}"),
                    buildDetailContainer('Godina proizvodnje', widget.automobil.godinaProizvodnje.toString()),
                    buildDetailContainer('Pređeni kilometri',widget.automobil.predjeniKilometri.toString()),
                    buildDetailContainer('Snaga motora',widget.automobil.snagaMotora ?? "null"),
                    buildDetailContainer('Boja',widget.automobil.boja ?? "null"),
                    buildDetailContainer('Broj vrata',widget.automobil.brojVrata.toString()),
                    buildDetailContainer('Broj šasije',widget.automobil.brojSasije.toString()),
                    buildDetailContainer('Vrsta goriva',widget.automobil.vrstaGoriva ?? "null"),
                    const SizedBox(height: 10),
                    buildCarAccessoryTile(context)
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTestDriveButton(context),
                  const SizedBox(width: 10),
                  buildCheckoutButton(context)
                ],
              )
            ],
          ),
         ),
       )
    );
  }

  MaterialButton buildCheckoutButton(BuildContext context) {
    return MaterialButton(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  color: Colors.grey[600],
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const CheckoutPage()));
                },
                child: const Text("ONLINE PLAĆANJE", style: TextStyle(color: Colors.white),),);
  }

  MaterialButton buildTestDriveButton(BuildContext context) {
    return MaterialButton(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  color: Colors.grey[600],
                  onPressed: (){
                    showDialog(context: context, builder: (context) =>  TestDriveDialog(automobilId: widget.automobil.automobilId!,));
                },
                child:const Text("TESTNA VOŽNJA", style: TextStyle(color: Colors.white),),);
  }

  Container buildCarAccessoryTile(BuildContext context) {
    return Container(
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CarAccessories(auto: widget.automobil,)));
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
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