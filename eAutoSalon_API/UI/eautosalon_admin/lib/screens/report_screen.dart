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
  final _formKey = GlobalKey<FormBuilderState>();
  int totalUsers = 0;
  double average = 0.00;
  late ReviewProvider _reviewProvider;
  late UserProvider _userProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _reviewProvider = context.read<ReviewProvider>();
    _userProvider=context.read<UserProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Izvještaj',
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: isLoading ? const Center(child: CircularProgressIndicator(),)
          : SingleChildScrollView(
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
  
  Future<void> fetchData() async{
    try {
      var avg = await _reviewProvider.getAverage();
      var total = await _userProvider.getTotalNumber();
      setState(() {
        average=avg;
        totalUsers = total;
        isLoading=false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
