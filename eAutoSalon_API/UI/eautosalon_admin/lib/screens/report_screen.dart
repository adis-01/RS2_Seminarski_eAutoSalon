import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Izvještaj',
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBack(context),
                    buildHelper()
                  ],
                ),
                const SizedBox(height: 5),
                buildSearch(context),
                Container(
                  width: 900,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white70),
                  child: Column(
                    children: [
                      buildHeader(),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 20, left: 20),
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: buildReport(context),
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildFooterData()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingEnabled: false);
  }

  Tooltip buildHelper() {
    return Tooltip(
                    message: 'Za pretragu po mjesecima odaberite mjesec iz padajućeg menija i kliknite na dugme',
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey
                      ),
                      child: const Icon(Icons.question_mark, color: Colors.white,),
                    ),
                  );
  }

  Container buildSearch(BuildContext context) {
    return Container(
        width: 900,
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                  
                  SizedBox(
                    width: 250,
                    child: FormBuilderDropdown(
                      focusColor: Colors.grey[300],
                      name: 'mjesec',
                      initialValue: 'Svi',
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Mjesec',
                          labelStyle: const TextStyle(color: Colors.blueGrey)),
                      items: [
                        DropdownMenuItem(
                          child: Text('Svi'), value:'Svi'),
                        
                        DropdownMenuItem(
                          child: Text('Januar'), value: 'January',)
                      ],
                    ),
                  )
                ,
              Tooltip(
                message: 'Pretraga',
                child: MaterialButton(
                  disabledColor: Colors.grey[400],
                  color: Colors.black87,
                  padding: const EdgeInsets.all(20),
                  shape: const CircleBorder(),
                  onPressed: () {},
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Column buildReport(BuildContext context) {
    return Column(
      children: [
        Center(
          child: buildTable(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Ukupno:",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 3),
            Text(
              "\$15,423.00",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }

  SingleChildScrollView buildTable() {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(
              label: Icon(
            Icons.directions_car,
            color: Colors.grey[700],
          )),
          DataColumn(
              label: Text("\$",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.green[500],
                      fontWeight: FontWeight.bold))),
          DataColumn(
              label: Icon(
            Icons.person,
            color: Colors.grey[700],
          )),
          DataColumn(
              label: Icon(
            Icons.business,
            color: Colors.grey[700],
          )),
          DataColumn(
              label: Icon(
            Icons.date_range,
            color: Colors.grey[700],
          ))
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('Audi A6')),
            DataCell(Text('\$15,423.00')),
            DataCell(Text('Kupac')),
            DataCell(Text('Uposlenik')),
            DataCell(Text('Datum'))
          ])
        ],
      ),
    );
  }

  Row buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(Icons.directions_car, size: 35, color: Colors.blueGrey),
        Text("eAutoSalon", style: TextStyle(letterSpacing: 3,fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey),)
      ],
    );
  }

  Row buildFooterData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: const [
            Text("Ukupno korisnika",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 3),
            Text("25",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87))
          ],
        ),
        Column(
          children: const [
            Text(
              "Prosječna ocjena",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "3.28",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }

  MaterialButton buildBack(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.all(15),
        shape: const CircleBorder(),
        color: Colors.blueGrey,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => const HomePageScreen()));
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ));
  }
}
