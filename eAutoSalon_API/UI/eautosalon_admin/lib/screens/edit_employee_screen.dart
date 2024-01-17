// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/employee_provider.dart';
import 'package:eautosalon_admin/screens/employees_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/employee_picture_dialog.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/employee.dart';

class EditEmployee extends StatefulWidget {
  Employee employee;
  EditEmployee({super.key, required this.employee});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late EmployeeProvider _employeeProvider;

  @override
  void initState() {
    super.initState();
    _employeeProvider = context.read<EmployeeProvider>();
    _initialValue = {
      'FirstName': widget.employee.firstName,
      'LastName': widget.employee.lastName,
      'Kontakt': widget.employee.kontakt,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      floatingEnabled: false,
      title:
          'Detalji uposlenika ${widget.employee.firstName} ${widget.employee.lastName}',
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildBack(context),
              const SizedBox(height: 45),
              Container(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 15),
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    border: Border.all(color: Colors.blueGrey, width: 0.4),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: _buildForm(context),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(15),
                width: 500,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 0.4),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline, color: Color(0xFF248BD6)),
                    SizedBox(height: 3),
                    Text(
                        "Popunite sva polja, a promjene spasite klikom na dugme 'Spasi'",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FormBuilder _buildForm(BuildContext context) {
    return FormBuilder(
                key: _formKey,
                initialValue: _initialValue,
                child: Column(
                  children: [
                    _buildImage(),
                    const SizedBox(height: 30),
                    Wrap(
                      spacing: 15,
                      runSpacing: 20,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            name: 'FirstName',
                            decoration: const InputDecoration(
                              labelText: 'Ime',
                              border: OutlineInputBorder()
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                            ]),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            name: 'LastName',
                            decoration: const InputDecoration(
                              labelText: 'Prezime',
                              border: OutlineInputBorder(),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                            ]),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: FormBuilderTextField(
                            style: const TextStyle(fontSize: 15),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            name: 'Kontakt',
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                              FormBuilderValidators.email(context,errorText: 'Email neispravnog formata'),
                            ]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(
                        color: Colors.blueGrey,
                        thickness: 0.3,
                        indent: 15,
                        endIndent: 15),
                    const SizedBox(height: 15),
                    _buildButton(),
                  ],
                ),
              );
  }

  Row _buildBack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          shape: const CircleBorder(),
          color: Colors.blueGrey,
          padding: const EdgeInsets.all(15),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (builder)=> const EmployeesScreen())
            );
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        )
      ],
    );
  }

 

  Widget _buildButton() {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          onPressed: () async {
            try {
              if(_formKey.currentState != null){
                if(_formKey.currentState!.saveAndValidate()){
                  await _employeeProvider.update(widget.employee.uposlenikId!, _formKey.currentState!.value);
                  CustomDialogs.showSuccess(context, 'Uspješno uređivanje podataka', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (builder)=>const EmployeesScreen())
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
              backgroundColor: Colors.blueGrey),
          child: const Text('Spasi')),
    );
  }

  Stack _buildImage() {
    return Stack(alignment: Alignment.bottomRight, children: [
      SizedBox(
        width: 250,
        child: 
        widget.employee.slika != "" ?
        fromBase64String(widget.employee.slika!)
        : Image.asset("assets/images/no_profile_pic.png", fit: BoxFit.fill, color: Colors.blueGrey,),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
              border: Border.all(width: 1.5, color: Colors.white)),
          child: Tooltip(
            message: 'Promijeni sliku',
            child: IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context){
                    return EmployeePictureChange(employee: widget.employee);
                  });
                },
                icon: const Icon(Icons.camera_alt, color: Colors.white)),
          ),
        ),
      )
    ]);
  }
}
