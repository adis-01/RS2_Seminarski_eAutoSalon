// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/employee_provider.dart';
import 'package:eautosalon_admin/screens/employees_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/employee.dart';

class EditEmployee extends StatefulWidget {
  Employee employee;
  EditEmployee({super.key, required this.employee});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {

  late EmployeeProvider _employeeProvider;
  late TextEditingController first;
  late TextEditingController last;
  late TextEditingController contact;

  @override
  void initState() {
    super.initState();
    _employeeProvider = context.read<EmployeeProvider>();
      first = TextEditingController(text: widget.employee.firstName);
      last = TextEditingController(text: widget.employee.lastName);
      contact = TextEditingController(text: widget.employee.kontakt);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
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
                      child: Column(
                        children: [
                          _buildImage(),
                          const SizedBox(height: 30),
                          Wrap(
                            spacing: 15,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              _buildInput('Ime', first),
                              _buildInput('Prezime', last),
                              SizedBox(width: 280,child: _buildInput('Kontakt', contact)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Divider(color: Colors.blueGrey, thickness: 0.3, indent: 15, endIndent: 15),
                          const SizedBox(height: 15),
                          _buildButton(),
                        ],
                      ),
                    ),
                  const SizedBox(height: 5),
                  Container(
                      padding: const EdgeInsets.all(15),
                      width: 500,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 0.4
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const[
                          Icon(Icons.info_outline,  color:Color(0xFF248BD6)),
                          SizedBox(height: 3),
                          Text("Popunite sva polja, a promjene spasite klikom na dugme 'Spasi'", style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
  }

  Row _buildBack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          shape: const CircleBorder(),
          color: const Color(0xFF248BD6),
          padding: const EdgeInsets.all(15),
          onPressed: () {
            Navigator.of(context).pop();
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

  SizedBox _buildInput(String hint, TextEditingController controller) {
    return SizedBox(
      width: 200,
      height: 60,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
        onPressed: () async {
          try {
            var req = {
            'FirstName' : first.text,
            'LastName' : last.text,
            'Kontakt' : contact.text
          };
          await _employeeProvider.update(widget.employee.uposlenikId!, req);
          CustomDialogs.showSuccess(context, 'Uspješno uređivanje podataka', () { 
            Navigator.of(context).push(
              MaterialPageRoute(builder: (builder)=> const EmployeesScreen())
            );
          });
          } catch (e) {
            CustomDialogs.showError(context, e.toString());
          }
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(80, 40),
            backgroundColor: const Color(0xFF248BD6)),
        child: const Text('Spasi'));
  }

  Stack _buildImage() {
    return Stack(alignment: Alignment.bottomRight, children: [
      Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: Colors.white)),
        child: Image.asset(
          "assets/images/employee.png",
          fit: BoxFit.fill,
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF248BD6),
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.white)),
          child: Tooltip(
            message: 'Promijeni sliku',
            child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt, color: Colors.white)),
          ),
        ),
      )
    ]);
  }


}
