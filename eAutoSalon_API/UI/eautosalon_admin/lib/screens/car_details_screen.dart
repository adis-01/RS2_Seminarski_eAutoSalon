
// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/edit_car_dialog.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  late CarProvider _carProvider;
  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
  }
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Detalji', 
      body: Container(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBack(context),
              Center(
                child: buildContainer1(),
              ),
              const SizedBox(height: 5),
            Center(
              child: buildContainer2(),
            )
            ],
          ),
        ),
      )
      );
  }

  Container buildContainer2() {
    return Container(
              width: 500,
              height: 300,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white54,
              ),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  primary: true,
                  child: Column(
                    children: [
                      buildDetail('Cijena', '\$99.999'),
                      const SizedBox(height: 3),
                      buildDetail('Boja', 'Bijela'),
                      const SizedBox(height: 3),
                      buildDetail('Godina proizvodnje', '2016'),
                      const SizedBox(height: 3),
                      buildDetail('Snaga motora', '150KS'),
                      const SizedBox(height: 3),
                      buildDetail('Vrsta goriva', 'Benzin'),
                      const SizedBox(height: 3),
                      buildDetail('Predjeni kilometri', '0'),
                      const SizedBox(height: 3),
                      buildDetail('Broj vrata', '4/5'),
                      const SizedBox(height: 3),
                      buildDetail('Broj šasije', '17'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: (){
                          showDialog(context: context, builder: (context){
                            return const Placeholder();
                          });
                        }, 
                      style:ElevatedButton.styleFrom(backgroundColor: const Color(0xFF248BD6), minimumSize: const Size(50, 45)),
                      child: const Text("Dodatna oprema", style: TextStyle(color: Colors.white))),
                      const SizedBox(height: 5)
                    ],
                  ),
                ),
              ),
            );
  }

  SizedBox buildDetail(String label, String value) {
    return SizedBox(
                  width: 400,
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(label, style: const TextStyle(fontSize: 16, color: Colors.blueGrey, fontWeight: FontWeight.w700)),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(value, style: const TextStyle(fontSize: 17, color: Colors.black54, fontWeight: FontWeight.bold)),
                      ) 
                    ),
                  ),
                );
  }

  Container buildContainer1() {
    return Container(
                width: 500,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white54,
                ),
                child: Column(
                  children: [
                    buildIconButtons(),
                    const SizedBox(height: 5),
                  Image.network("https://img.freepik.com/free-psd/white-car-isolated_176382-1488.jpg?w=1060&t=st=1704911316~exp=1704911916~hmac=fb4b166588486ffbd0b0f3804e8374a0e4ae2eff11a202e48e80f89c7a75825a",height: 180,width: double.infinity, fit: BoxFit.cover)
                  ],
                ),
              );
  }

  Row buildIconButtons() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tooltip(
                          message: 'Uredi',
                          child: IconButton(
                            splashRadius: 5,
                            onPressed: (){
                             showDialog(context: context, builder: (context){
                              return const EditCar();
                             });
                            },
                            icon: const Icon(Icons.edit, color: Colors.black87, size: 25,),
                          ),
                        ),
                        Tooltip(
                          message: 'Obriši',
                          child: IconButton(
                            splashRadius: 5,
                            onPressed: (){
                              //  CustomDialogs.showQuestion(context, 'Da li želite izbrisati automobil?', () async{ 
                              //   try {
                              //     await _carProvider.delete(widget.automobilId);
                              //     Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HomePageScreen()));
                              //   } catch (e) {
                              //     CustomDialogs.showError(context, e.toString());
                              //   }
                              // });
                            },
                            icon: Icon(Icons.delete, color: Colors.red[300], size: 25,),
                          ),
                        )
                      ],
                    );
  }

  Widget buildBack(BuildContext context) {
    return  MaterialButton(
          shape: const CircleBorder(),
          color: const Color(0xFF248BD6),
          padding: const EdgeInsets.all(15),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => const HomePageScreen()));
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        );
  }

}