import 'package:eautosalon_admin/providers/employee_provider.dart';
import 'package:eautosalon_admin/screens/employees_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';

class InsertEmployee extends StatefulWidget {
  const InsertEmployee({super.key});

  @override
  State<InsertEmployee> createState() => _InsertEmployeeState();
}

class _InsertEmployeeState extends State<InsertEmployee> {
  //late EmployeeProvider _employeeProvider;

  @override
  void initState() {
    super.initState();
    //_employeeProvider=context.read<EmployeeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          padding: const EdgeInsets.all(20),
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Novi uposlenik',
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
                        color: Colors.deepPurpleAccent,
                      ))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(80, 40)),
                      child: const Text('Poništi', style:TextStyle(fontSize: 15),)
                      ),
                  ElevatedButton(
                      onPressed: () {
                        try {
                          //await _employeeProvider.insert(request);
                          CustomDialogs.showSuccess(context, 'Uspješno dodan novi uposlenik', () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (builder) => const EmployeesScreen())
                            );
                           });
                        } catch (e) {
                          CustomDialogs.showError(context, e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(80, 40)),
                      child: const Text('Dodaj')
                      )
                ],
              )
            ],
          )),
    );
  }
}
