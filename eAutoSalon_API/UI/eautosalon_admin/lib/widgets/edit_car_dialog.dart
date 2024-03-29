
// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';

class EditCar extends StatefulWidget {
  Automobil automobil;
  EditCar({super.key, required this.automobil});

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
    _initialValue = {
      'Proizvodjac' : widget.automobil.proizvodjac,
      'Model' : widget.automobil.model,
      'BrojSasije' : widget.automobil.brojSasije,
      'GodinaProizvodnje' : widget.automobil.godinaProizvodnje.toString(),
      'SnagaMotora' : widget.automobil.snagaMotora,
      'Cijena' : widget.automobil.cijena.toString()
    };
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[300],
      child: Container(
        width: 600,
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
                    const Icon(Icons.settings, color: Colors.blueGrey, size: 25),
                    IconButton(
                      splashRadius: 20,
                      onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: const Icon(Icons.close, size: 25, color: Colors.blueGrey,))
                  ],
                ),
                const Divider(thickness: 0.3, color: Colors.blueGrey, height: 25),
                buildInputs(context),
                const SizedBox(height: 20),
                SizedBox(width: 200, height: 42,child: buildButtons(context))
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton buildButtons(BuildContext context) {
    return 
                  MaterialButton(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    color: Colors.blueGrey,
                    onPressed: () async{
                      if(_formKey.currentState != null){
                        if(_formKey.currentState!.saveAndValidate()){
                          try {
                            await _carProvider.update(widget.automobil.automobilId!, _formKey.currentState!.value);
                            CustomDialogs.showSuccess(context, "Uspješno uređivanje podataka", () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HomePageScreen()));
                             });
                          } catch (e) {
                            CustomDialogs.showError(context, e.toString());
                          }
                        }
                      }
                    }, child: const Text('Spasi', style: TextStyle(color: Colors.white),));
  }

  Wrap buildInputs(BuildContext context) {
    return Wrap(
                spacing: 15,
                runSpacing: 20,
                children: [
                  SizedBox(
                    width: 230,
                    child: FormBuilderTextField(
                      cursorColor: Colors.grey,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'Proizvodjac',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno'),
                        (value){
                          if(value!=null && value.startsWith(" ")){
                            return 'Počnite slovom';
                          }
                          else{
                            return null;
                          }
                        }
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Proizvođač'
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 230,
                    child: FormBuilderTextField(
                      cursorColor: Colors.grey,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'Model',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno'),
                        (value){
                          if(value!=null && value.startsWith(" ")){
                            return 'Počnite slovom';
                          }
                          else{
                            return null;
                          }
                        }
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Model'
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 230,
                    child: FormBuilderTextField(
                      cursorColor: Colors.grey,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'SnagaMotora',
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Polje je obavezno';
                        }
                        else if(!value.contains("KS") && !value.contains("KW")){
                          return 'Jačina mora biti izražena u KS ili KW';
                        }
                        else if(value.contains(" ")){
                          return 'Prazno polje nije dozvoljeno';
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Snaga motora'
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 230,
                    child: FormBuilderTextField(
                      cursorColor: Colors.grey,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'BrojSasije',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno'),
                        FormBuilderValidators.minLength(context, 17, errorText: 'Tačno 17 znakova'),
                        FormBuilderValidators.maxLength(context, 17, errorText: 'Tačno 17 znakova'),
                        (value){
                          if(value != null && value.contains(" ")){
                            return 'Prazno polje nije dozvoljeno';
                          }
                          else{
                            return null;
                          }
                        }
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Broj šasije'
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 230,
                    child: FormBuilderTextField(
                      cursorColor: Colors.grey,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'GodinaProizvodnje',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno'),
                        FormBuilderValidators.integer(context, errorText: 'Samo brojevi'),
                        (value){
                          if(value != null && value.contains(" ")){
                            return 'Prazno polje nije dozvoljeno';
                          }
                          else{
                            return null;
                          }
                        }
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Godina proizvodnje'
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 230,
                    child: FormBuilderTextField(
                      cursorColor: Colors.grey,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'Cijena',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno'),
                        FormBuilderValidators.numeric(context, errorText: 'Samo brojevi, primjer 25321.99'),
                        (value){
                          if(value != null && value.contains(" ")){
                            return 'Prazno polje nije dozvoljeno';
                          }
                          else{
                            return null;
                          }
                        }
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Cijena'
                      ),
                    ),
                  )
                ],
              );
  }
}
