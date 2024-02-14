import 'package:eautosalon_admin/models/report_dto.dart';
import 'package:eautosalon_admin/models/report_model.dart';
import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/providers/report_provider.dart';
import 'package:eautosalon_admin/providers/review_provider.dart';
import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  Map<String,dynamic> filter = {'mjesec' : 0};
  int initialValue = 0;
  ReportModel? report;
  final _formKey = GlobalKey<FormBuilderState>();
  int totalUsers = 0;
  int totalActiveProducts = 0;
  double average = 0.00;
  late ReviewProvider _reviewProvider;
  late UserProvider _userProvider;
  late ReportProvider _reportProvider;
  late CarProvider _carProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _reviewProvider = context.read<ReviewProvider>();
    _userProvider = context.read<UserProvider>();
    _reportProvider = context.read<ReportProvider>();
    _carProvider=context.read<CarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Izvještaj',
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueGrey,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [buildBack(context), buildHelper()],
                      ),
                      const SizedBox(height: 15),
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
                            const SizedBox(height: 15),
                            report?.list != null ? report!.list.isNotEmpty ? buildTable() : const Center(child: Text("Nema podataka o kupljenim proizvodima", style: TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w500, wordSpacing: 1),),) : const Text(""),
                            const SizedBox(height: 10),
                            Text("Ukupno: \$${report?.formattedPrice ?? "null"}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black54),),
                            const SizedBox(height: 20),
                            const Divider(thickness: 0.2, color: Colors.black54, indent: 20, endIndent: 20,),
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

  DataTable buildTable() {
    return DataTable(
                              decoration:
                                  const BoxDecoration(color: Colors.white30),
                              border: TableBorder.all(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(5),
                                  width: 0.5),
                              columns: const [
                                DataColumn(
                                    label: Expanded(
                                        child: Text('Datum prodaje',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.w700)))),
                                DataColumn(
                                    label: Expanded(
                                        child: Text('Automobil',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.w700)))),
                                DataColumn(
                                    label: Expanded(
                                        child: Text('Kupac',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.w700)))),
                                DataColumn(
                                    label: Expanded(
                                        child: Text('Iznos',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.w700)))),
                              ],
                              rows: report?.list
                .map((ReportDto item) => DataRow(cells: [
                      DataCell(Text(item.datum)),
                      DataCell(Text(item.proizvod ?? "null")),
                      DataCell(Text(item.kupac ?? "null")),
                      DataCell(Text("\$${item.formattedPrice ?? "null"}")),
                    ]))
                .toList() ?? []
              );
  }

  Tooltip buildHelper() {
    return Tooltip(
      message:
          'Za pretragu po mjesecima odaberite mjesec iz padajućeg menija i kliknite na dugme',
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
        child: const Icon(
          Icons.question_mark,
          color: Colors.white,
        ),
      ),
    );
  }

  Container buildSearch(BuildContext context) {
    return Container(
        width: 900,
        padding: const EdgeInsets.all(5),
        child: Center(
          child: FormBuilder(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250,
                  child: FormBuilderDropdown(
                    onChanged: (value){
                      setState(() {
                        filter = {'mjesec' : int.parse(value.toString())};
                        initialValue = value!;
                      });
                    },
                    focusColor: Colors.grey[300],
                    name: 'mjesec',
                    initialValue: initialValue,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Mjesec',
                        labelStyle: const TextStyle(color: Colors.blueGrey)),
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Svi')),
                      DropdownMenuItem(value: 1, child: Text('Januar')),
                      DropdownMenuItem(value: 2, child: Text('Februar')),
                      DropdownMenuItem(value: 3, child: Text('Mart')),
                      DropdownMenuItem(value: 4, child: Text('April')),
                      DropdownMenuItem(value: 5, child: Text('Maj')),
                      DropdownMenuItem(value: 6, child: Text('Juni')),
                      DropdownMenuItem(value: 7, child: Text('Juli')),
                      DropdownMenuItem(value: 8, child: Text('August')),
                      DropdownMenuItem(value: 9, child: Text('Septembar')),
                      DropdownMenuItem(value: 10, child: Text('Oktobar')),
                      DropdownMenuItem(value: 11, child: Text('Novembar')),
                      DropdownMenuItem(value: 12, child: Text('Decembar'))
                    ],
                  ),
                ),
                Tooltip(
                  message: 'Pretraga',
                  child: MaterialButton(
                    disabledColor: Colors.grey[400],
                    color: Colors.black87,
                    padding: const EdgeInsets.all(20),
                    shape: const CircleBorder(),
                    onPressed: () {
                      setState(() {
                        isLoading=true;
                      });
                      fetchData();
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Row buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(Icons.directions_car, size: 35, color: Colors.blueGrey),
        Text(
          "eAutoSalon",
          style: TextStyle(
              letterSpacing: 3,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey),
        )
      ],
    );
  }

  Row buildFooterData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text("Ukupno korisnika",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text(totalUsers.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87))
          ],
        ),
        Column(
          children: [
            const Text("Aktivni oglasi",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text(totalActiveProducts.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87))
          ],
        ),
        Column(
          children: [
            const Text(
              "Prosječna ocjena",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            Text(
              average.toStringAsFixed(2),
              style: const TextStyle(
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

  Future<void> fetchData() async {
    try {
      var avg = await _reviewProvider.getAverage();
      var total = await _userProvider.getTotalNumber();
      var list = await _reportProvider.getZavrseni(filters: filter);
      var totalCars = await _carProvider.getTotalNumber();
      setState(() {
        average = avg;
        totalUsers = total;
        report=list;
        totalActiveProducts=totalCars;
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
