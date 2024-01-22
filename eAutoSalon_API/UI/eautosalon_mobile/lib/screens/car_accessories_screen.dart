import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class CarAccessories extends StatefulWidget {
  const CarAccessories({super.key});

  @override
  State<CarAccessories> createState() => _CarAccessoriesState();
}

class _CarAccessoriesState extends State<CarAccessories> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Dodatna oprema', 
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  Text("PROIZVODJAC MODEL", style: TextStyle(color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.w400),),
                  Icon(Icons.cable, size: 25, color: Colors.black87,)
                ],
              ),
              const SizedBox(height: 25),
              // const Center(
              //   child: Text("NEMA PODATAKA O OPREMI OVOG AUTOMOBILA", style: TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.w400),),
              // )
              Wrap( 
                spacing: 5,
                runSpacing: 10,
                children: [
                  buildAccessoryContainer('Klima',true),
                  buildAccessoryContainer('Naslonjač za ruke', false),
                  buildAccessoryContainer('Parking senzori', true),
                  buildAccessoryContainer('Parking kamera', true),
                  buildAccessoryContainer('ABS', true),
                  buildAccessoryContainer('El. podizači stakala', false),
                  buildAccessoryContainer('Start-Stop sistem', false),
                  buildAccessoryContainer('Tempomat', false),
                  buildAccessoryContainer('Alarm', true),
                  buildAccessoryContainer('Zračni jastuk', true),
                  buildAccessoryContainer('USB Port', true),
                  buildAccessoryContainer('Bluetooth', true),
                  buildAccessoryContainer('Komande na volanu', false),
                  buildAccessoryContainer('Navigacija', true)
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Container buildAccessoryContainer(String title, bool value) {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title.toUpperCase(), style: const TextStyle(fontSize: 15,color: Colors.white, fontWeight: FontWeight.w500),),
                    Icon(value ? Icons.check_circle : Icons.cancel, size: 25,color: Colors.white70,)
                  ],
                ),
              );
  }
}