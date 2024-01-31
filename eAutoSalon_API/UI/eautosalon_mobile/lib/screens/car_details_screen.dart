// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/screens/car_accessories_screen.dart';
import 'package:eautosalon_mobile/screens/checkout_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
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
                SizedBox(
                    height: 330,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildRecommendedBox(),
                    ))
              ],
            ),
          ),
        ));
  }

  Container buildRecommendedBox() {
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
              SizedBox(
                height: 135,
                width: double.infinity,
                child: fromBase64String(widget.automobil.slika!),
              ),
              const SizedBox(height: 10),
              const Text(
                "Proizvođač model",
                style: TextStyle(
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
              const Text(
                "\$99,999.99",
                style: TextStyle(
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
                  onPressed: () {},
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
}
