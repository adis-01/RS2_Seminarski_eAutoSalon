
// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class EditCar extends StatefulWidget {
  const EditCar({super.key});

  @override
  State<EditCar> createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String,dynamic> _initialValue = {};
  late CarProvider _carProvider;

  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
    // _initialValue = {
    //   'Proizvodjac' : widget.auto.proizvodjac,
    //   'Model' : widget.auto.model,
    //   'BrojSasije' : widget.auto.brojSasije,
    //   'GodinaProizvodnje' : widget.auto.godinaProizvodnje,
    //   'SnagaMotora' : wiget.auto.snagaMotora
    // };
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.settings, color: Color(0xFF248BD6), size: 25),
                    IconButton(
                      splashRadius: 20,
                      onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: const Icon(Icons.close, size: 25, color: Color(0xFF248BD6),))
                  ],
                ),
                const Divider(thickness: 0.3, color: Colors.blueGrey, height: 25),
                buildInputs(context),
                const SizedBox(height: 20),
                buildButtons(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Wrap buildButtons(BuildContext context) {
    return Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF248BD6), minimumSize: const Size(75,40)),
                    onPressed: (){
                    Navigator.of(context).pop();
                  }, child: const Text('Poništi')),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF248BD6), minimumSize: const Size(75,40)),
                    onPressed: () async{
                      if(_formKey.currentState != null){
                        if(_formKey.currentState!.saveAndValidate()){
                          // try {
                          //   await _carProvider.update(widget.auto.automobilId, _formKey.currentState!.value);
                          //   CustomDialogs.showSuccess(context, "Uspješno uređivanje podataka", () {
                          //     Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const EditCar()));
                          //    });
                          // } catch (e) {
                          //   CustomDialogs.showError(context, e.toString());
                          // }
                        }
                      }
                    }, child: const Text('Spasi'))
                ],
              );
  }

  Wrap buildInputs(BuildContext context) {
    return Wrap(
                spacing: 15,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: 200,
                    child: FormBuilderTextField(
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'Proizvodjac',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno')
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Proizvođač'
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 200,
                    child: FormBuilderTextField(
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'Model',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno')
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Model'
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 200,
                    child: FormBuilderTextField(
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'SnagaMotora',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno')
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Snaga motora'
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 200,
                    child: FormBuilderTextField(
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'BrojSasije',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno'),
                        FormBuilderValidators.minLength(context, 17, errorText: 'Tačno 17 znakova'),
                        FormBuilderValidators.maxLength(context, 17, errorText: 'Tačno 17 znakova')
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Broj šasije'
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 200,
                    child: FormBuilderTextField(
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'GodinaProizvodnje',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno'),
                        FormBuilderValidators.integer(context, errorText: 'Samo brojevi')
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Godina proizvodnje'
                      ),
                    ),
                  )
                ],
              );
  }
}

//  public intPredjeniKilometri { get; set; }
//  //SnagaMotora { get; set; } = null!;
// // Proizvodjac { get; set; } = null!;
// // BrojSasije { get; set; } = null!;
// // Model { get; set; } = null!;
// GodinaProizvodnje { get; set; } 