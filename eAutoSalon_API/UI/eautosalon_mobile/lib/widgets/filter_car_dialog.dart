import 'package:eautosalon_mobile/providers/car_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class FilterCar extends StatefulWidget {
  const FilterCar({super.key});

  @override
  State<FilterCar> createState() => _FilterCarState();
}

class _FilterCarState extends State<FilterCar> {
  List<String> _listaProizvodjaca = [];
  bool isLoading = true;
  late CarProvider _carProvider;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black87,
                  ),
                )
              : FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildBackIcon(context),
                      const Text(
                        "Pređeni kilometri < od",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      buildKilometraza(),
                      const Text(
                        "Godina proizvodnje < od",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      buildGodinaProiz(),
                      buildProizvodjaci(),
                      buildBrojVrata(),
                      buildVrstaGoriva(),
                      const SizedBox(height: 20),
                      buildSearchButton()
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Padding buildVrstaGoriva() {
    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: FormBuilderDropdown(
                          name: 'TipGoriva',
                          initialValue: 'Svi',
                          items: const [
                            DropdownMenuItem(
                              value: 'Svi',
                              child: Text("Svi"),
                            ),
                            DropdownMenuItem(
                              value: 'Benzin',
                              child: Text("Benzin"),
                            ),
                            DropdownMenuItem(
                              value: 'Dizel',
                              child: Text("Dizel"),
                            ),
                            DropdownMenuItem(
                              value: 'Plin',
                              child: Text("Plin"),
                            ),
                          ],
                          decoration: InputDecoration(
                              labelText: 'Vrsta goriva',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    );
  }

  Padding buildBrojVrata() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FormBuilderDropdown(
          name: 'BrojVrata',
          items: const [
            DropdownMenuItem(
              value: 2,
              child: Text("2/3"),
            ),
            DropdownMenuItem(
              value: 4,
              child: Text("4/5"),
            ),
          ],
          decoration: InputDecoration(
              labelText: 'Broj vrata',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
    );
  }

  GestureDetector buildSearchButton() {
    return GestureDetector(
      onTap: () {
        if(_formKey.currentState != null){
          if(_formKey.currentState!.saveAndValidate()){
            Navigator.of(context).pop(_formKey.currentState!.value);
          }
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.black87),
        child: const Text(
          "PRETRAGA",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              letterSpacing: 1,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Row buildBackIcon(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black87,
              size: 25,
            ))
      ],
    );
  }

  Padding buildKilometraza() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: 'PredjenaKilometraza',
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.numeric(context, errorText: 'Samo brojevi'),
          FormBuilderValidators.maxLength(context, 7, errorText: 'Max. 7 brojeva')
        ]),
      ),
    );
  }

  Padding buildGodinaProiz() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: 'GodinaProizvodnje',
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.numeric(context, errorText: 'Samo brojevi'),
          FormBuilderValidators.maxLength(context, 4, errorText: 'Max. 4 broja')
        ]),
      ),
    );
  }

  Padding buildProizvodjaci() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FormBuilderDropdown(
        name: 'Proizvodjac',
        initialValue: 'Svi',
        items: List.generate(
            _listaProizvodjaca.length,
            (index) => DropdownMenuItem(
                  value: _listaProizvodjaca[index],
                  child: Text(_listaProizvodjaca[index]),
                )),
        decoration: InputDecoration(
            labelText: 'Proizvođač',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      var data = await _carProvider.getProizvodjace();
      setState(() {
        _listaProizvodjaca = data;
        isLoading = false;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
