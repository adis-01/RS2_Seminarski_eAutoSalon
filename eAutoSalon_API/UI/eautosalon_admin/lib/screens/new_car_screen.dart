// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:file_picker/file_picker.dart';
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
  File? _image;
  String? _base64image;
  String hint = "Klik za upload slike";
  bool insertLoading = false;

  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      floatingEnabled: false,
      title: 'Novi automobil',
      body: !insertLoading ? Container(
        padding: const EdgeInsets.all(20),
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
      ) : const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),),
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
              SizedBox(width: 5),
              Text(
                "Popunite sva polja, a podatke spasite klikom na dugme",
                style: TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(
              color: Colors.blueGrey,
              thickness: 0.3,
              endIndent: 10,
              indent: 10),
          const SizedBox(height: 5),
          buildInputs(),
          const SizedBox(height: 10),
          const Divider(
            thickness: 0.3,
            indent: 10,
            endIndent: 10,
            color: Colors.blueGrey,
          ),
          const SizedBox(height: 10),
          buildButtons(context),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 0.2),
            ),
            child: const Text(
              "Opciju za dodavanje opreme novog/već postojećeg automobila možete naći na detaljima istog",
              style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500),
            ),
          )
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
            cursorColor: Colors.grey,
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
            cursorColor: Colors.grey,
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
            cursorColor: Colors.grey,
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
            cursorColor: Colors.grey,
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
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: 'GodinaProizvodnje',
            decoration: const InputDecoration(
              labelText: 'Godina proizvodnje',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Polje obavezno'),
              FormBuilderValidators.numeric(context, errorText: 'Samo brojevi')
            ]),
          ),
        ),
        SizedBox(
          width: 250,
          child: FormBuilderTextField(
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: 'PredjeniKilometri',
            decoration: const InputDecoration(
              labelText: 'Kilometraža',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Polje obavezno'),
              FormBuilderValidators.numeric(context, errorText: 'Samo brojevi')
            ]),
          ),
        ),
        SizedBox(
          width: 250,
          child: FormBuilderTextField(
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: 'SnagaMotora',
            decoration: const InputDecoration(
              labelText: 'Snaga motora',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                          return 'Polje je obavezno';
                        }
                        else if(!value.contains("KS") && !value.contains("KW")){
                          return 'Jačina mora biti izražena u KS ili KW';
                        }
                        else{
                          return null;
                        }
            },
          ),
        ),
        SizedBox(
          width: 250,
          child: FormBuilderTextField(
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: 'BrojVrata',
            decoration: const InputDecoration(
              labelText: 'Broj vrata',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Polje obavezno'),
            ]),
          ),
        ),
        buildDropdown(),
         SizedBox(
                    width: 250,
                    child: FormBuilderTextField(
                      cursorColor: Colors.grey,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'Cijena',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje je obavezno'),
                        FormBuilderValidators.numeric(context, errorText: 'Samo brojevi, primjer 25321.99')
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        labelText: 'Cijena'
                      ),
                    ),
                  ),
         FormBuilderField(
            name: 'slikaBase64',
            validator: (value) {
              if (_image == null) {
                return 'Polje je obavezno';
              } else {
                return null;
              }
            },
            builder: (field) {
              return SizedBox(
                width: 250,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    hintText: hint,
                    suffixIcon: const Icon(Icons.upload),
                    errorText: field.errorText
                  ),
                  onTap: uploadImage,
                ),
              );
            },
          ),
      ],
    );
  }

  Future<void> uploadImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64image = base64Encode(_image!.readAsBytesSync());
      setState(() {
        hint = result.files.single.name.toString();
      });
    }
  }

  SizedBox buildDropdown() {
    return SizedBox(
      width: 250,
      child: FormBuilderDropdown(
          decoration: const InputDecoration(
            labelText: 'Gorivo',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          name: 'VrstaGoriva',
          initialValue: 'Benzin',
          dropdownColor: const Color(0xFF83B8FF),
          items: const [
            DropdownMenuItem(
                value: "Benzin",
                child: Text("Benzin",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold))),
            DropdownMenuItem(
                value: "Dizel",
                child: Text("Dizel",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold))),
            DropdownMenuItem(
                value: "Plin",
                child: Text("Plin",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold))),
             DropdownMenuItem(
                value: "Hibrid",
                child: Text("Hibrid",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold))),
            DropdownMenuItem(
                value: "Elektro",
                child: Text("Elektro",
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold))),
          ]),
    );
  }

  Row buildBack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(15),
          color: Colors.blueGrey,
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
    return SizedBox(
      width: 200,
      height: 42,
      child: MaterialButton(
          color: Colors.blueGrey,
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () async {
            if (_formKey.currentState != null) {
              if (_formKey.currentState!.saveAndValidate()) {
                Map<String,dynamic> map = Map.from(_formKey.currentState!.value);
                map['slikaBase64'] = _base64image;
                try {
                  await _carProvider.insert(map);
                  setState(() {
                    insertLoading=false;
                  });
                  CustomDialogs.showSuccess(
                      context, 'Uspješno dodan novi automobil', () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => const HomePageScreen()));
                  });
                } catch (e) {
                  setState(() {
                    insertLoading=false;
                  });
                  CustomDialogs.showError(context, e.toString());
                }
              }
            }
          },
          child: const Text('Spasi', style: TextStyle(fontSize: 15, color: Colors.white),)),
    );
  }
}
