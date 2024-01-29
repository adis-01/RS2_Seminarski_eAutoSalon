import 'package:eautosalon_mobile/providers/employee_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/employee.dart';
import '../models/search_result.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late EmployeeProvider _employeeProvider;
  bool isLoading = true;
  SearchResult<Employee>? result;

  @override
  void initState() {
    super.initState();
    _employeeProvider = context.read<EmployeeProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Uposlenici',
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black87,
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    children: [
                      const Text(
                        "NAŠ TIM",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: result?.list
                                .map((Employee obj) => buildEmployeeCard(obj))
                                .toList() ??
                            [],
                      )
                    ],
                  ),
                ),
              ));
  }

  Container buildEmployeeCard(Employee employee) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 130,
            child: employee.slika == ""
             ?  
            Icon(Icons.no_photography_rounded, size: 30, color: Colors.blue[600],) :
            fromBase64String(employee.slika!),
          ),
          const SizedBox(height: 5),
          Text(
            "${employee.firstName ?? "null"} ${employee.lastName ?? "null"}",
            style: const TextStyle(fontSize: 17, color: Colors.black54, fontWeight: FontWeight.w500, letterSpacing: 0.7),
          ),
          const SizedBox(height: 8),
          Text(
            employee.title?.toUpperCase() ?? "null",
            style: const TextStyle(fontSize: 16,letterSpacing: 0.5, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
          const SizedBox(height: 15),
          Text(
            employee.kontakt ?? "null",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.2, color: Colors.blueGrey),
          )
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      var data = await _employeeProvider.getAktivne();
      if (mounted) {
        setState(() {
          result = data;
          isLoading = false;
        });
      }
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
