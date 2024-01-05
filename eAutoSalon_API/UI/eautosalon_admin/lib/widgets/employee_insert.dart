// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/employee_provider.dart';
import 'package:eautosalon_admin/screens/employees_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsertEmployee extends StatefulWidget {
  const InsertEmployee({super.key});

  @override
  State<InsertEmployee> createState() => _InsertEmployeeState();
}

class _InsertEmployeeState extends State<InsertEmployee> {
  late EmployeeProvider _employeeProvider;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _contact = TextEditingController();
  String selValue = "Prodaja";

  @override
  void initState() {
    super.initState();
    _employeeProvider=context.read<EmployeeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(25),
            width: 650,
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
                    _buildInput('Ime', _firstName),
                    _buildInput('Prezime', _lastName),
                    _buildInput('Kontakt', _contact),
                    SizedBox(width:250, height:50, child: _buildDropList()),
                  ],
                ),
                const SizedBox(height: 20),
                    
                _buildButtons(context),
                const SizedBox(height: 20),
                _buildInfo()
              ],
            )),
      ),
    );
  }

  SizedBox _buildInput(String hint, TextEditingController controller) {
    return SizedBox(
      width: 250,
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  DropdownButton<String> _buildDropList() {
    return DropdownButton(
        focusColor: Colors.blueAccent,
        borderRadius: BorderRadius.circular(5),
        dropdownColor: const Color(0xFF83B8FF),
        elevation: 15,
        value: selValue,
        items: const [
          DropdownMenuItem(
              value: "Prodaja",
              child: Text("Prodaja",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold))),
          DropdownMenuItem(
              value: "CEO",
              child: Text("CEO",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold))),
          DropdownMenuItem(
              value: "Administracija",
              child: Text("Administracija",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold))),
          DropdownMenuItem(
              value: "Testiranje",
              child: Text("Testiranje",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold))),
        ],
        onChanged: (value) {
          setState(() {
            selValue = value.toString();
          });
        });
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
                var obj = {
                  'FirstName' : _firstName.text,
                  'LastName' : _lastName.text,
                  'Title' : selValue,
                  'Kontakt' : _contact.text
                };
                await _employeeProvider.insert(obj);
                CustomDialogs.showSuccess(
                    context, 'Uspješno dodan novi uposlenik', () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => const EmployeesScreen()));
                });
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
    return  Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blueGrey,
            width: 0.2
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.info_outline, color: Color(0xFF248BD6)),
            Text("U polja unesite validne podatke, a iz liste odaberite pripadajuću poziciju uposlenika", style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      );
  }
}
