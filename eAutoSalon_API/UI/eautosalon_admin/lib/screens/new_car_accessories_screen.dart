// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/screens/car_details_screen.dart';
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
  final FocusNode _klimaFocus = FocusNode();
  final FocusNode _kameraFocus = FocusNode();
  final FocusNode _senzorFocus = FocusNode();
  final FocusNode _jastukFocus = FocusNode();
  final FocusNode _navigacijaFocus = FocusNode();
  final FocusNode _tempomatFocus = FocusNode();
  final FocusNode _alarmFocus = FocusNode();
  final FocusNode _usbFocus = FocusNode();
  final FocusNode _bluetoothFocus = FocusNode();
  final FocusNode _volanFocus = FocusNode();
  final FocusNode _naslonjacFocus = FocusNode();
  final FocusNode _startStopFocus = FocusNode();
  final FocusNode _absFocus = FocusNode();
  final FocusNode _podizaciFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _opremaProvider = context.read<DodatnaOpremaProvider>();
  }

  @override
  void dispose() {
    super.dispose();
    _klimaFocus.dispose();
    _kameraFocus.dispose();
    _senzorFocus.dispose();
    _jastukFocus.dispose();
    _navigacijaFocus.dispose();
    _tempomatFocus.dispose();
    _alarmFocus.dispose();
    _usbFocus.dispose();
    _bluetoothFocus.dispose();
    _volanFocus.dispose();
    _naslonjacFocus.dispose();
    _startStopFocus.dispose();
    _absFocus.dispose();
    _podizaciFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        floatingEnabled: false,
        title: 'Dodatna oprema',
        body: Container(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: !insertLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        shape: const CircleBorder(),
                        color: Colors.blueGrey,
                        padding: const EdgeInsets.all(15),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => CarDetails(
                                    automobil: widget.automobil,
                                  )));
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildForm(),
                      const SizedBox(height: 15),
                      buildButtons()
                    ],
                  )
                : const Center(child: CircularProgressIndicator(color: Colors.blueGrey,)),
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
                borderRadius: BorderRadius.circular(12), color: Colors.white60),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 5,
              runSpacing: 5,
              children: [
                buildSwitch('klima', 'Klima', _klimaFocus),
                buildSwitch('parkingKamera', 'Parking kamera', _kameraFocus),
                buildSwitch('parkingSenzori', 'Parking senzori',_senzorFocus),
                buildSwitch('zracniJastuk', 'Zračni jastuk',_jastukFocus),
                buildSwitch('navigacija', 'Navigacija',_navigacijaFocus),
                buildSwitch('tempomat', 'Tempomat',_tempomatFocus),
                buildSwitch('alarm', 'Alarm',_alarmFocus),
                buildSwitch('usbport', 'USB Port',_usbFocus),
                buildSwitch('bluetooth', 'Bluetooth',_bluetoothFocus),
                buildSwitch('komandeVolan', 'Komande na volanu',_volanFocus),
                buildSwitch('naslonjacRuka', 'Naslonjač za ruku',_naslonjacFocus),
                buildSwitch('startStop', 'Start-Stop sistem',_startStopFocus),
                buildSwitch('abskocinice', 'ABS',_absFocus),
                buildSwitch('podizaciStakala', 'El. podizači stakala',_podizaciFocus),
              ],
            )),
      ),
    );
  }

  Center buildButtons() {
    return Center(
        child: SizedBox(
          width: 200,
          height: 42,
          child: MaterialButton(
              padding: const EdgeInsets.all(15),
              color: Colors.blueGrey,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                setState(() {
                  insertLoading = true;
                });
                saveData();
              },
              child: const Text(
                "Sačuvaj",
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
        ));
  }

  Container buildSwitch(String name, String title, FocusNode node) {
    return Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        width: 230,
        child: FormBuilderSwitch(
          focusNode: node,
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

  Future<void> saveData() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.saveAndValidate()) {
        Map<String, dynamic> map = Map.from(_formKey.currentState!.value);
        map['automobilId'] = widget.automobil.automobilId;
        try {
          await _opremaProvider.insert(map);
          setState(() {
            insertLoading = false;
          });
          CustomDialogs.showSuccess(context, 'Uspješno dodana oprema', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => CarDetails(automobil: widget.automobil)));
          });
        } catch (e) {
          setState(() {
            insertLoading = false;
          });
          CustomDialogs.showError(context, e.toString());
        }
      }
    }
  }
}
