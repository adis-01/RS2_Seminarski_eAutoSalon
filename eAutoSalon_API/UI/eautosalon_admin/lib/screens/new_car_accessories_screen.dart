// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/screens/car_details_screen.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';
import '../providers/accesories_provider.dart';

class NewCarAccessories extends StatefulWidget {
  Automobil automobil;
  NewCarAccessories({super.key, required this.automobil});

  @override
  State<NewCarAccessories> createState() => _NewCarAccessoriesState();
}

class _NewCarAccessoriesState extends State<NewCarAccessories> {
  final _formKey = GlobalKey<FormBuilderState>();
  late DodatnaOpremaProvider _opremaProvider;
  bool insertLoading = false;

  @override
  void initState() {
    super.initState();
    _opremaProvider = context.read<DodatnaOpremaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        floatingEnabled: false,
        title: 'Dodatna oprema',
        body: Container(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child:  !insertLoading ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  shape: const CircleBorder(),
                  color: const Color(0xFF248BD6),
                  padding: const EdgeInsets.all(15),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CarDetails(automobil: widget.automobil,)));
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.white,size: 25,),
                  ),
                  const SizedBox(height: 10),
                  buildForm(),
                  const SizedBox(height: 15),
                  buildButtons()
              ],
            ) : const Center(child: CircularProgressIndicator()) ,
          ),
        ));
  }

  Widget buildForm() {
    return FormBuilder(
      key: _formKey,
      child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 700,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white60
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          buildSwitch('klima', 'Klima'),
                          buildSwitch('parkingKamera', 'Parking kamera'),
                          buildSwitch('parkingSenzori', 'Parking senzori'),
                          buildSwitch('zracniJastuk', 'Zračni jastuk'),
                          buildSwitch('navigacija', 'Navigacija'),
                          buildSwitch('tempomat', 'Tempomat'),
                          buildSwitch('alarm', 'Alarm'),
                          buildSwitch('usbport', 'USB Port'),
                          buildSwitch('bluetooth', 'Bluetooth'),
                          buildSwitch('komandeVolan', 'Komande na volanu'),
                          buildSwitch('naslonjacRuka', 'Naslonjač za ruku'),
                          buildSwitch('startStop', 'Start-Stop sistem'),
                          buildSwitch('abskocinice', 'ABS'),
                          buildSwitch('podizaciStakala', 'El. podizači stakala'),
                        ],
                      )
                    ),
                  ),
    );
  }

  Center buildButtons() {
    return Center(
                  child: Wrap(
                    spacing: 40,
                    runSpacing: 20,
                    children: [
                      MaterialButton(
                        padding: const EdgeInsets.all(20),
                        color: const Color(0xFF248BD6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HomePageScreen()));
                        }, 
                        child: const Text("Poništi", style: TextStyle(fontSize: 15, color: Colors.white),)),
                      MaterialButton(
                        padding: const EdgeInsets.all(20),
                        color: const Color(0xFF248BD6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        onPressed: (){
                          setState(() {
                            insertLoading = true;
                          });
                          saveData();
                          }, 
                        child: const Text("Sačuvaj", style: TextStyle(fontSize: 15, color: Colors.white),))
                    ],
                  ),
                );
  }

  Container buildSwitch(String name, String title) {
    return Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        width: 230,
        child: FormBuilderSwitch(
          initialValue: false,
          name: name,
          title: Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey)),
          activeColor: Colors.black87,
          decoration: const InputDecoration(border: InputBorder.none),
        ));
  }
  
  Future<void> saveData() async{
    if(_formKey.currentState != null){
      if(_formKey.currentState!.saveAndValidate()){
        Map<String,dynamic> map = Map.from(_formKey.currentState!.value);
        map['automobilId'] = widget.automobil.automobilId;
        try {
          await _opremaProvider.insert(map);
          setState(() {
            insertLoading=false;
          });
          CustomDialogs.showSuccess(context, 'Uspješno dodana oprema', () { 
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CarDetails(automobil: widget.automobil)));
          }); 
        } catch (e) {
          setState(() {
            insertLoading=false;
          });
          CustomDialogs.showError(context, e.toString());
        }
      }
    }
  }
}
