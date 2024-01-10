import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class NewCarScreen extends StatefulWidget {
  const NewCarScreen({super.key});

  @override
  State<NewCarScreen> createState() => _NewCarScreenState();
}

class _NewCarScreenState extends State<NewCarScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late CarProvider _carProvider;

  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Novi automobil',
      body: Container(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildBack(context),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  width: 600,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(15)),
                  child: buildForm(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  FormBuilder buildForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          Wrap(
            
            children: const [
              Icon(Icons.info_outline_rounded,
                  color: Color(0xFF248BD6), size: 25),
              SizedBox(width: 10),
              Text(
                "Popunite sva polja, a podatke spasite klikom na dugme",
                style: TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
              color: Colors.blueGrey,
              thickness: 0.3,
              endIndent: 10,
              indent: 10),
          const SizedBox(height: 10),
          buildInputs(),
          const SizedBox(height: 15),
          const Divider(thickness: 0.3, indent: 10, endIndent: 10, color: Colors.blueGrey,),
          const SizedBox(height: 15),
          buildButtons(context)
        ],
      ),
    );
  }

  Wrap buildInputs() {
    return Wrap(
          runAlignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 10,
          children: [
            SizedBox(
              width: 250,
              child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'Proizvodjac',
                decoration: const InputDecoration(
                  labelText: 'Proizvođač',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context,
                      errorText: 'Polje obavezno')
                ]),
              ),
            ),
            SizedBox(
              width: 250,
              child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'Model',
                decoration: const InputDecoration(
                  labelText: 'Model',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context,
                      errorText: 'Polje obavezno')
                ]),
              ),
            ),
            SizedBox(
              width: 250,
              child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'Boja',
                decoration: const InputDecoration(
                  labelText: 'Boja',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context,
                      errorText: 'Polje obavezno')
                ]),
              ),
            ),
            SizedBox(
              width: 250,
              child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'BrojSasije',
                decoration: const InputDecoration(
                  labelText: 'Broj šasije',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context,
                      errorText: 'Polje obavezno'),
                  FormBuilderValidators.minLength(context, 17,
                      errorText: 'Tačno 17 znakova'),
                  FormBuilderValidators.maxLength(context, 17,
                      errorText: 'Tačno 17 znakova')
                ]),
              ),
            ),
            SizedBox(
              width: 250,
              child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'GodinaProizvodnje',
                decoration: const InputDecoration(
                  labelText: 'Godina proizvodnje',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                  FormBuilderValidators.numeric(context, errorText: 'Samo brojevi')
                ]),
              ),
            ),
            SizedBox(
              width: 250,
              child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'PredjeniKilometri',
                decoration: const InputDecoration(
                  labelText: 'Kilometraža',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                  FormBuilderValidators.numeric(context, errorText: 'Samo brojevi')
                ]),
              ),
            ),
            SizedBox(
              width: 250,
              child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'SnagaMotora',
                decoration: const InputDecoration(
                  labelText: 'Snaga motora',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                ]),
              ),
            ),
            SizedBox(
              width: 250,
              child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: 'BrojVrata',
                decoration: const InputDecoration(
                  labelText: 'Broj vrata',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                ]),
              ),
            ),
            buildDropdown(),
          ],
        );
  }

  SizedBox buildDropdown() {
    return SizedBox(
                    width: 250,
                    child: FormBuilderDropdown(
                      decoration: const InputDecoration(
                        labelText: 'Gorivo',
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                      name: 'VrstaGoriva', 
                      initialValue: 'Benzin',
                      dropdownColor: const Color(0xFF83B8FF),
                      items: const [
                      DropdownMenuItem(
                          value: "Benzin",
                          child: Text("Benzin",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold))),
                      DropdownMenuItem(
                          value: "Dizel",
                          child: Text("Dizel",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold))),
                      DropdownMenuItem(
                          value: "Plin",
                          child: Text("Plin",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold))),
                    ]),
                  );
  }

  Row buildBack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(15),
          color: const Color(0xFF248BD6),
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
        ),
      ],
    );
  }

  Widget buildButtons(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF248BD6),
            minimumSize: const Size(100, 50)),
        onPressed: () async {
          if (_formKey.currentState != null) {
            if (_formKey.currentState!.saveAndValidate()) {}
          }
        },
        child: const Text('Spasi'));
  }
}
