import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

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
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        color: Colors.black87,
                        padding: const EdgeInsets.all(15),
                        onPressed: (){
                          MyDialogs.showSuccess(context, 'TODO Dodatna', () { 
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text("DODATNA OPREMA", style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.w500),),),
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

                  },
                  child:const Text("TESTNA VOŽNJA", style: TextStyle(color: Colors.white),),),
                  const SizedBox(width: 10),
                  MaterialButton(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    color: Colors.grey[600],
                    onPressed: (){

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