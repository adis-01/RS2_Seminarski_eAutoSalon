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
        body: isLoading ?
            const Center(child: CircularProgressIndicator(color: Colors.black87,))
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              children: [
                const Text(
                  "NAŠ TIM",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
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
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //slika
          SizedBox(
            width: double.infinity,
            height: 140,
            child: Center(
                child: employee.slika != ""
                    ? fromBase64String(employee.slika!)
                    : const Icon(
                        Icons.no_photography,
                        size: 80,
                        color: Colors.black87,
                      )),
          ),
          const SizedBox(height: 5),
          //ime i prezime
          Text(
            "${employee.firstName ?? "null"} ${employee.lastName ?? "null"}",
            style: const TextStyle(
                color: Colors.black54,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          const SizedBox(height: 5),
          //pozicija
          Text(
            employee.title?.toUpperCase() ?? "NO TITLE",
            style: const TextStyle(
                color: Colors.grey, fontSize: 15, letterSpacing: 1.5),
          ),
          const SizedBox(height: 15),
          //kontakt
          Row(
            children: [
              const Icon(
                Icons.mail,
                size: 25,
                color: Colors.black54,
              ),
              const SizedBox(width: 8),
              Text(
                "${employee.kontakt}",
                style: const TextStyle(
                    color: Colors.black87,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      var data = await _employeeProvider.getAll();
      setState(() {
        result = data;
        isLoading = false;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
