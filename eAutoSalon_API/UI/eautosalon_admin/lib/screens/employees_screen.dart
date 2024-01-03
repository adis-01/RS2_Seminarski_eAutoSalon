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
  late EmployeeProvider _employeeProvider;

  @override
  void initState() {
    super.initState();
    _employeeProvider = context.read<EmployeeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Uposlenici',
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    shape: const CircleBorder(),
                    color: Colors.deepPurpleAccent,
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
                  Tooltip(
                    message: 'Novi uposlenik',
                    child: MaterialButton(
                      shape: const CircleBorder(),
                      color: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.all(15),
                      onPressed: () {
                        _openInsertEmployee();
                      },
                      child: const Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    _buildCard(context),
                    _buildCard(context),
                    _buildCard(context)
                  ],
                ),
              )
              )
            ],
          ),
        ));
  }

  Container _buildCard(BuildContext context) {
    return Container(
              width: 280,
              height: 250,
              decoration: const BoxDecoration(
                  color: Color(0xFFFFF8E8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                  )),
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
                                CustomDialogs.showQuestion(
                                    context,
                                    'Izbrisati uposlenika Ime_Prezime',
                                    () {});
                              },
                              icon: Icon(Icons.delete_outline,
                                  color: Colors.red[300], size: 25)),
                        ),
                        Text('Ime_Prezime', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black)),
                        Tooltip(
                          message: 'Uredi',
                          child: IconButton(
                            splashRadius: 0.1,
                            onPressed: (){

                          }, 
                          icon: const Icon(Icons.edit, color: Color(0xFFFD9E7E), size:25)),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Image.asset("assets/images/employee.png", width: 200, height: 100),
                    const SizedBox(height: 15),
                    const Text('CEO', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.blueGrey),),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mail, size: 25, color: Colors.blueGrey,),
                        const SizedBox(width: 10),
                        const Text('ups@eautosalon.ba', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black87),)
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
            );
  }

  void _openInsertEmployee() {
    showDialog(
        context: context,
        builder: (context) {
          return const InsertEmployee();
        });
  }
}
