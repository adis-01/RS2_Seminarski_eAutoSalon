// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:eautosalon_admin/providers/employee_provider.dart';
import 'package:eautosalon_admin/screens/employees_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class InsertEmployee extends StatefulWidget {
  const InsertEmployee({super.key});

  @override
  State<InsertEmployee> createState() => _InsertEmployeeState();
}

class _InsertEmployeeState extends State<InsertEmployee> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool insertLoading = false;
  late EmployeeProvider _employeeProvider;
  String hint = "Klik za upload";
  File? image;
  String? base64image;

  @override
  void initState() {
    super.initState();
    _employeeProvider = context.read<EmployeeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(25),
            width: 650,
            child: !insertLoading ? _buildForm(context) : const Center(child: CircularProgressIndicator())
            ),
      ),
    );
  }

  FormBuilder _buildForm(BuildContext context) {
    return FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                const SizedBox(height: 5),
                const Divider(
                    thickness: 0.3,
                    color: Colors.blueGrey,
                    indent: 15,
                    endIndent: 15),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 45,
                  runSpacing: 20,
                  runAlignment: WrapAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 250,
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'FirstName',
                        decoration: const InputDecoration(
                          labelText: 'Ime',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'Polje obavezno'),
                          FormBuilderValidators.minLength(context, 2,
                              errorText: 'Unesite više od 1 znaka')
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'LastName',
                        decoration: const InputDecoration(
                          labelText: 'Prezime',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'Polje obavezno'),
                          FormBuilderValidators.minLength(context, 2,
                              errorText:
                                  'Polje mora imati minimalno 2 slova'),
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'Kontakt',
                        decoration: const InputDecoration(
                          labelText: 'Kontakt',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'Polje obavezno'),
                          FormBuilderValidators.email(context,
                              errorText: 'ime.prezime@{mailprovider}.{com}')
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: FormBuilderDropdown(
                        decoration: const InputDecoration(
                          labelText: 'Pozicija',
                          border: OutlineInputBorder(),
                        ),
                        name: 'Title', 
                        initialValue: 'Prodaja',
                        dropdownColor: const Color(0xFF83B8FF),
                        items: const [
                        DropdownMenuItem(
                            value: "Prodaja",
                            child: Text("Prodaja",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold))),
                        DropdownMenuItem(
                            value: "CEO",
                            child: Text("CEO",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold))),
                        DropdownMenuItem(
                            value: "Administracija",
                            child: Text("Administracija",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold))),
                        DropdownMenuItem(
                            value: "Testiranje",
                            child: Text("Testiranje",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold))),
                      ]),
                    ),
                    SizedBox(
                      width: 250,
                      child: FormBuilderField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'slikaBase64',
                        builder: (field){
                          return InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                            border: const OutlineInputBorder(),
                            labelText: 'Slika',
                            suffixIcon: const Icon(
                              Icons.upload,
                              color: Colors.blueGrey,
                            ),
                            errorText: field.errorText,
                          ),
                          child: ListTile(
                            title: Text(hint,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blueGrey),),
                            onTap: uploadImage,
                          )
                          );
                        },
                        validator: (field){
                          if(image == null){
                            return 'Polje je obavezno';
                          }
                          else{
                            return null;
                          }
                        }
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                _buildButtons(context),
                const SizedBox(height: 20),
                _buildInfo()
              ],
            ),
          );
  }

  Future<void> uploadImage() async{
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if(result != null && result.files.single.path != null){
      image = File(result.files.single.path!);
      base64image = base64Encode(image!.readAsBytesSync());
      setState(() {
        hint = result.files.single.name.toString();
      });
    }
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Uposlenik',
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              letterSpacing: 0.3,
              color: Colors.blueGrey),
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              size: 25,
              color: Color(0xFF248BD6),
            ))
      ],
    );
  }

  Row _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 40),
              backgroundColor: const Color(0xFF248BD6),
            ),
            child: const Text(
              'Poništi',
              style: TextStyle(fontSize: 15),
            )),
        ElevatedButton(
            onPressed: () async {
              setState(() {
                insertLoading = true;
              });
              try {
                if(_formKey.currentState != null){
                  if(_formKey.currentState!.saveAndValidate()){
                    Map<String,dynamic> map = Map.from(_formKey.currentState!.value);
                    map['slikaBase64'] = base64image;
                    await _employeeProvider.insert(map);
                    setState(() {
                      insertLoading=false;
                    });
                    CustomDialogs.showSuccess(context, 'Uspješno dodan novi uposlenik', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => const EmployeesScreen())
                      );
                     });
                  }
                }
              } catch (e) {
                setState(() {
                  insertLoading=false;
                });
                CustomDialogs.showError(context, e.toString());
              }
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(80, 40),
                backgroundColor: const Color(0xFF248BD6)),
            child: const Text('Dodaj'))
      ],
    );
  }

  Widget _buildInfo() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey, width: 0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_outline, color: Color(0xFF248BD6)),
          Text(
              "U polja unesite validne podatke, a iz liste odaberite pripadajuću poziciju uposlenika",
              style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
