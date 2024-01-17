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

import '../models/employee.dart';

class EmployeePictureChange extends StatefulWidget {
  Employee employee;
  EmployeePictureChange({super.key, required this.employee});

  @override
  State<EmployeePictureChange> createState() => _EmployeePictureChangeState();
}

class _EmployeePictureChangeState extends State<EmployeePictureChange> {
  late EmployeeProvider _employeeProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  File? _image;
  String? _base64image;
  String _hint = "Kliknite za upload";


  @override
  void initState() {
    super.initState();
    _employeeProvider=context.read<EmployeeProvider>();
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.blueGrey,
        elevation: 15,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(20),
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildClose(context),
                const SizedBox(height: 15),
                FormBuilder(
                  key: _formKey,
                  child: FormBuilderField(
                    name: 'slika',
                    validator: (value) {
                      if (_image == null) {
                        return 'Polje je obavezno';
                      } else {
                        return null;
                      }
                    },
                    builder: (field) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Slika',
                          suffixIcon: const Icon(
                            Icons.upload,
                            color: Colors.blueGrey,
                          ),
                          errorText: field.errorText,
                        ),
                        child: ListTile(
                          title: Text(
                            _hint,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic),
                          ),
                          onTap: uploadImage,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(80, 40),
                         backgroundColor: Colors.blueGrey,
                        ),
                        child: const Text(
                          'Poništi',
                          style: TextStyle(fontSize: 15),
                        )),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.saveAndValidate()) {
                              var map = Map.from(_formKey.currentState!.value);
                              map['slika'] = _base64image;
                              await _employeeProvider.changePic(widget.employee.uposlenikId!, map);
                              CustomDialogs.showSuccess(context, 'Uspješno spremljena slika', () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (builder) => const EmployeesScreen())
                                );
                               });
                            }
                          } catch (e) {
                            CustomDialogs.showError(context, e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 40),
                           backgroundColor: Colors.blueGrey),
                        child: const Text('Dodaj'))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Row _buildClose(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            splashRadius: 15,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close, size: 25, color: Colors.blueGrey))
      ],
    );
  }

  Future uploadImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64image = base64Encode(_image!.readAsBytesSync());
      setState(() {
        _hint = result.files.single.name.toString();
      });
    }
  }
}
