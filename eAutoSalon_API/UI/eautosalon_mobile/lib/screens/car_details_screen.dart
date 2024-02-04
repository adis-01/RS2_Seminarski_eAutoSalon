// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/providers/car_provider.dart';
import 'package:eautosalon_mobile/screens/car_accessories_screen.dart';
import 'package:eautosalon_mobile/screens/checkout_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:eautosalon_mobile/widgets/test_drive_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';

class CarDetails extends StatefulWidget {
  final Car automobil;
  const CarDetails({super.key, required this.automobil});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {

  List<Car> _list = [];
  late CarProvider _carProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carProvider=context.read<CarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Detalji',
        body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black87,),) 
        : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: widget.automobil.slika == ""
                        ? const Icon(Icons.no_photography)
                        : fromBase64String(widget.automobil.slika!),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.automobil.proizvodjacModel ?? "null",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
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
                      buildDetailContainer(
                          'Cijena', "\$${widget.automobil.formattedPrice}"),
                      buildDetailContainer('Godina proizvodnje',
                          widget.automobil.godinaProizvodnje.toString()),
                      buildDetailContainer('Pređeni kilometri',
                          widget.automobil.predjeniKilometri.toString()),
                      buildDetailContainer('Snaga motora',
                          widget.automobil.snagaMotora ?? "null"),
                      buildDetailContainer(
                          'Boja', widget.automobil.boja ?? "null"),
                      buildDetailContainer(
                          'Broj vrata', widget.automobil.brojVrata.toString()),
                      buildDetailContainer('Broj šasije',
                          widget.automobil.brojSasije.toString()),
                      buildDetailContainer('Vrsta goriva',
                          widget.automobil.vrstaGoriva ?? "null"),
                          
                      const SizedBox(height: 10),
                      buildTile(context, 'DODATNA OPREMA', Icons.cable, () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) =>
                                CarAccessories(auto: widget.automobil)));
                      }),
                      buildTile(context, 'TESTNA VOŽNJA', Icons.directions_car,
                          () async {
                        var result = await showDialog(
                            context: context,
                            builder: (context) => TestDriveDialog(
                                  automobilId: widget.automobil.automobilId!,
                                ));
                        if (result != null &&
                            result.toString().contains("ok")) {
                          MyDialogs.showSuccess(context,
                              'Uspješna rezervacija, istu možete provjeriti u odgovarajućoj sekciji na Korisničkom profilu',
                              () {
                            Navigator.of(context).pop();
                          });
                        }
                      }),
                      buildTile(context, 'ONLINE PLAĆANJE', Icons.credit_card, () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CheckoutPage(car: widget.automobil)));
                       })
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "PREPORUČENO",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 0.5),
                ),
                _list.isNotEmpty ? SizedBox(
                    height: 330,
                    child: ListView.builder(
                      itemCount: _list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildRecommendedBox(_list[index]),
                    )) : const Text("Nema preporučenih proizvoda", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),textAlign: TextAlign.center,)
              ],
            ),
          ),
        ));
  }

  Container buildRecommendedBox(Car object) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
             object.slika !=  "" ? SizedBox(
                height: 135,
                width: double.infinity,
                child: fromBase64String(object.slika!),
              ) : const Center(child: Icon(Icons.no_photography, size: 25, color: Colors.black,),),
              const SizedBox(height: 10),
              Text(
                "${object.proizvodjac ?? "null"} ${object.model ?? "null"}",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${object.formattedPrice}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(20))),
                width: 60,
                height: 40,
                child: MaterialButton(
                  padding: const EdgeInsets.all(5),
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) =>  CarDetails(automobil: object)));
                  },
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildTile(BuildContext context, String title, IconData icon,
      VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black87),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        title: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          color: Colors.white,
          iconSize: 25,
          onPressed: onPressed,
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
          borderRadius: BorderRadius.circular(12), color: Colors.grey[300]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            naslov,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          Text(
            vrijednost,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
  
  Future<void> fetchData() async{
    try {
      var data = await _carProvider.recommend(widget.automobil.automobilId!);
      if(mounted){
        setState(() {
        _list=data;
        isLoading=false;
      });
      }
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
