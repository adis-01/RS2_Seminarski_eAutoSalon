// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/models/employee.dart';
import 'package:eautosalon_admin/models/search_result.dart';
import 'package:eautosalon_admin/screens/edit_employee_screen.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';
import '../widgets/employee_insert.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  SearchResult<Employee>? result;
  bool isLoading = true;
  late EmployeeProvider _employeeProvider;
  int currentRating = 1;

  @override
  void initState() {
    super.initState();
    _employeeProvider = context.read<EmployeeProvider>();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      floatingEnabled: true,
        title: 'Uposlenici',
        onFloatingPressed: (){
          showDialog(context: context, builder: (context){
            return const InsertEmployee();
          });
        },
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          shape: const CircleBorder(),
                          color: Colors.blueGrey,
                          padding: const EdgeInsets.all(15),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => const HomePageScreen()));
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    result?.count != 0
                        ? Expanded(
                            child: SingleChildScrollView(
                            child: Wrap(
                                spacing: 50,
                                runSpacing: 25,
                                children: result?.list
                                        .map(
                                          (Employee item) =>
                                              _buildCard(context, item),
                                        )
                                        .toList() ??
                                    []),
                          ))
                        : const Center(
                            child: Text("No employees"),
                          ),
                  ],
                ),
              ));
  }


  Container _buildCard(BuildContext context, Employee employee) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 300,
      decoration: const BoxDecoration(
          color: Color(0xFFC4C4C4),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                  message: 'Obriši',
                  child: IconButton(
                      splashRadius: 0.1,
                      onPressed: () {
                        CustomDialogs.showQuestion(context,
                            'Izbrisati uposlenika ${employee.firstName ?? "null"} ${employee.lastName ?? "null"}?',
                            () async {
                          try {
                            await _employeeProvider
                                .changeState(employee.uposlenikId!);
                            CustomDialogs.showSuccess(
                                context, 'Uspješno obrisan uposlenik', () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) =>
                                      const EmployeesScreen()));
                            });
                          } catch (e) {
                            CustomDialogs.showError(context, e.toString());
                          }
                        });
                      },
                      icon: Icon(Icons.delete_outline,
                          color: Colors.red[270], size: 25)),
                ),
                Tooltip(
                  message: 'Uredi',
                  child: IconButton(
                      splashRadius: 0.1,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) =>
                                EditEmployee(employee: employee)));
                      },
                      icon: Icon(Icons.edit, color: Colors.red[270], size: 25)),
                )
              ],
            ),
            Text(
                '${employee.firstName ?? "null"} ${employee.lastName ?? "null"}',
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(height: 15),
            Text(
              '${employee.title}',
              style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            const SizedBox(height: 15),
            Text(
              '${employee.kontakt}',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }



  void _loadData() async {
    try {
      var data = await _employeeProvider.getAktivne();
      setState(() {
        result = data;
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
