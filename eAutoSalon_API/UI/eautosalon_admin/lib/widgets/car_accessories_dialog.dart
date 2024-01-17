import 'package:eautosalon_admin/models/car_accesories.dart';
import 'package:eautosalon_admin/screens/new_car_accessories_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';
import '../providers/accesories_provider.dart';

class CarAcc extends StatefulWidget {
  Automobil automobil;
  CarAcc({super.key, required this.automobil});

  @override
  State<CarAcc> createState() => _CarAccState();
}

class _CarAccState extends State<CarAcc> {
  late DodatnaOpremaProvider _dodatnaOpremaProvider;
  DodatnaOprema? oprema;
  bool isLoading = true;
  final _errorText = "Nema podataka o opremi ovog automobila!";
  final _questionText = "Da li želite dodati opremu?";
  bool showError = false;

  @override
  void initState() {
    super.initState();
    _dodatnaOpremaProvider = context.read<DodatnaOpremaProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              width: 800,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300]),
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: !showError
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildHeader(context),
                          const Divider(
                              thickness: 0.3,
                              color: Colors.blueGrey,
                              indent: 10,
                              endIndent: 10,
                              height: 20),
                          buildAccessories(),
                          const SizedBox(height: 20),
                          buildBack(context),
                        ],
                      )
                    : noDataDialog(context),
              ),
            ),
          );
  }

  Wrap buildAccessories() {
    return Wrap(
      spacing: 10, 
      runSpacing: 10, 
      children: [
        buildTextField("Klima", oprema!.klima!),
        buildTextField("ABS", oprema!.abskocinice!),
        buildTextField("Tempomat", oprema!.tempomat!),
        buildTextField("Bluetooth", oprema!.bluetooth!),
        buildTextField("Navigacija", oprema!.navigacija!),
        buildTextField("Naslonjač za ruku", oprema!.naslonjacRuka!),
        buildTextField("Parking kamera", oprema!.parkingKamera!),
        buildTextField("Parking senzori", oprema!.klima!),
        buildTextField("Alarm", oprema!.alarm!),
        buildTextField("El. podizači stakala", oprema!.podizaciStakala!),
        buildTextField("Start-Stop sistem", oprema!.startStop!),
        buildTextField("Zračni jastuk", oprema!.zracniJastuk!),
        buildTextField("USB Port", oprema!.usbport!),
        buildTextField("Komande na volanu", oprema!.komandeVolan!)
      ]);
  }

  Widget buildTextField(String opis, bool value) {
    return SizedBox(
        width: 230,
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                opis,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: value ? 
              Icon(Icons.check_circle_rounded, color: Colors.green[400],)
              : 
              Icon(Icons.cancel, color: Colors.red[400],)
            )
          ),
        ));
  }

  Center noDataDialog(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.question_mark, size: 25, color: Colors.blueGrey),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close,
                      size: 25, color: Colors.blueGrey))
            ],
          ),
          const SizedBox(height: 5),
          Text(
            _errorText,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            _questionText,
            style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 19,
                fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) =>
                          NewCarAccessories(automobil: widget.automobil)));
                },
                child: const Text(
                  "Da",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              MaterialButton(
                color: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Ne",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }

  Row buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Dodatna oprema",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey)),
        IconButton(
            splashRadius: 25,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              size: 25,
              color: Colors.blueGrey,
            ))
      ],
    );
  }

  ElevatedButton buildBack(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            fixedSize: const Size(80, 40)),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "Nazad",
          style: TextStyle(color: Colors.white),
        ));
  }

  Future<void> fetchData() async {
    try {
      var obj =
          await _dodatnaOpremaProvider.getOprema(widget.automobil.automobilId!);
      setState(() {
        oprema = obj;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        showError = true;
      });
    }
  }
}
