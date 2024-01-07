// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/employee_provider.dart';
import 'package:eautosalon_admin/screens/employees_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
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
  late EmployeeProvider _employeeProvider;

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
            child: _buildForm(context)
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
              try {
                if(_formKey.currentState != null){
                  if(_formKey.currentState!.saveAndValidate()){
                    await _employeeProvider.insert(_formKey.currentState!.value);
                    CustomDialogs.showSuccess(context, 'Uspješno dodan novi uposlenik', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => const EmployeesScreen())
                      );
                     });
                  }
                }
              } catch (e) {
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