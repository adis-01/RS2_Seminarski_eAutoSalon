import 'package:eautosalon_mobile/models/accessory.dart';
import 'package:eautosalon_mobile/providers/accessory_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';

class CarAccessories extends StatefulWidget {
  final Car auto;
  const CarAccessories({super.key, required this.auto});

  @override
  State<CarAccessories> createState() => _CarAccessoriesState();
}

class _CarAccessoriesState extends State<CarAccessories> {

  bool isLoading = true;
  DodatnaOprema? oprema;
  late OpremaProvider _opremaProvider;

  @override
  void initState() {
    super.initState();
    _opremaProvider = context.read<OpremaProvider>();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Dodatna oprema', 
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: isLoading ?
        const Center(child: CircularProgressIndicator(color: Colors.black87,),)
        :
         SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.auto.proizvodjacModel ?? "null", style: const TextStyle(color: Colors.blueGrey, fontSize: 17, fontWeight: FontWeight.w400),),
                  const Icon(Icons.cable, size: 28, color: Colors.black87,)
                ],
              ),
              const SizedBox(height: 30),
              oprema == null ? 
              noDataColumn()
              :
              Wrap( 
                spacing: 5,
                runSpacing: 10,
                children: [
                  buildAccessoryContainer('Klima',oprema!.klima!),
                  buildAccessoryContainer('Naslonjač za ruke', oprema!.naslonjacRuka!),
                  buildAccessoryContainer('Parking senzori', oprema!.parkingSenzori!),
                  buildAccessoryContainer('Parking kamera', oprema!.parkingKamera!),
                  buildAccessoryContainer('ABS', oprema!.abskocinice!),
                  buildAccessoryContainer('El. podizači stakala', oprema!.podizaciStakala!),
                  buildAccessoryContainer('Start-Stop sistem', oprema!.startStop!),
                  buildAccessoryContainer('Tempomat', oprema!.tempomat!),
                  buildAccessoryContainer('Alarm', oprema!.alarm!),
                  buildAccessoryContainer('Zračni jastuk', oprema!.zracniJastuk!),
                  buildAccessoryContainer('USB Port', oprema!.usbport!),
                  buildAccessoryContainer('Bluetooth', oprema!.bluetooth!),
                  buildAccessoryContainer('Komande na volanu', oprema!.komandeVolan!),
                  buildAccessoryContainer('Navigacija', oprema!.navigacija!)
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Column noDataColumn() {
    return Column(
              children: [
                Image.asset("assets/images/car_icon.png", width: 90, height: 90,),
                const SizedBox(height: 15),
                const Text("NEMA PODATAKA O OPREMI AUTOMOBILA", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400, fontSize: 17),)
              ],
            );
  }

  Container buildAccessoryContainer(String title, bool value) {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title.toUpperCase(), style: const TextStyle(fontSize: 15,color: Colors.white, fontWeight: FontWeight.w500),),
                    Icon(value ? Icons.check_circle : Icons.cancel, size: 25,color: Colors.white,)
                  ],
                ),
              );
  }
  
  Future<void> initialize() async{
    try {
      var data = await _opremaProvider.getOprema(widget.auto.automobilId!);
      setState(() {
        oprema = data;
        isLoading=false;
      });
    } catch (e) {
      if(e.toString().contains("Nema objekta sa tim id-om")){
        setState(() {
          oprema = null;
          isLoading=false;
        });
      }
      else{
        MyDialogs.showError(context, e.toString());
      }
    }
  }
}