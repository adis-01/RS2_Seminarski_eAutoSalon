// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/providers/test_drive_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class TestDriveDialog extends StatefulWidget {
  final int automobilId;
  const TestDriveDialog({super.key, required this.automobilId});

  @override
  State<TestDriveDialog> createState() => _TestDriveDialogState();
}

class _TestDriveDialogState extends State<TestDriveDialog> {

  DateTime datum = DateTime.now();
  late TestDriveProvider _testDriveProvider;
  bool isLoading = false;
  bool disabledButton = true;
  List<String> lista = [];
  String? termin;


  @override
  void initState() {
    super.initState();
    _testDriveProvider=context.read<TestDriveProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading ? 
          const Center(child: CircularProgressIndicator(color: Colors.black87,),)
          :
           Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildHeader(context),
              const Divider(thickness: 0.2, color: Colors.black54,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDateTimePickerButton(),
                  termin != "" && termin != null ?  
                  Text(termin!, style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500, letterSpacing: 1),) 
                  : const Text("")
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)
                ),
                child: lista.isEmpty ?
                Column(
                  children: const[
                    Icon(Icons.data_array_rounded, size: 25, color: Colors.black54,),
                    SizedBox(height: 10),
                    Text("Nema slobodnih termina / Odabrali ste subotu ili nedjelju", 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w500),),
                    SizedBox(height: 5)
                  ],
                )
                :
                 Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: lista.map((String time) => buildTimeStamp(time)).toList()
                 )
              ),
              buildButton(),
              buildInfo()
            ],
          ),
        ),
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMMMd().format(datum), style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),),
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: const Icon(Icons.close, size: 25, color: Colors.black87,))
              ], 
            );
  }

  Row buildDateTimePickerButton() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.black87,
                  padding: const EdgeInsets.all(10),
                  onPressed: () async{
                    final DateTime? date = await showDatePicker(
                      context: context, 
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.utc(2024, 12, 31));
                    if(date != null){
                      setState(() {
                        datum = date;
                        isLoading=true;
                        termin = null;
                      });
                      getAvailableAppointments();
                    }
                    else{
                      setState(() {
                        disabledButton = true;
                        termin = null;
                      });
                    }
                }, child: const Text(
                  "Odaberite datum",
                  style: TextStyle(
                    color: Colors.white, letterSpacing: 0.5, fontWeight: FontWeight.w500, fontSize: 15
                  ),
                  ),
                  ),
              ],
            );
  }

  Container buildInfo() {
    return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.black54,
                  width: 0.5
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Icon(Icons.info, color: Colors.grey[900], size: 20,),
                    const SizedBox(height: 5),
                    const Text("Odaberite datum, zatim satnicu, te izvršite rezervaciju klikom na dugme", style: TextStyle(fontSize: 15,letterSpacing: 0.5,fontWeight: FontWeight.w400, color: Colors.black87),)
                ],
              ),
            );
  }

  Center buildButton() {
    return Center(
        child: SizedBox(
          width: double.infinity,
          child: MaterialButton(
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.black87,
            disabledColor: Colors.grey,
            onPressed: 
            disabledButton ?
            null 
            :
            (){
              setState(() {
                isLoading = true;
              });
              saveData();
            },
            child: const Text("REZERVACIJA", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.5),),
          ),
        ),
    );
  }

  GestureDetector buildTimeStamp(String time) {
    return GestureDetector(
                    onTap: (){
                      setState(() {
                        termin = time;
                        disabledButton = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[800]
                      ),
                      child:  Text(
                        time, 
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  );
  }

  Future<void> getAvailableAppointments() async{
    try {
      var satnice = await _testDriveProvider.getSlobodne(widget.automobilId, datum);
      setState(() {
        lista=satnice;
        isLoading=false;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
  
  Future<void> saveData() async{
    try {
      String datumVrijeme = DateTime(
        datum.year,
        datum.month,
        datum.day,
        int.parse(termin!.split(':')[0]),
        int.parse(termin!.split(':')[1]),
      ).toIso8601String();
      var request = {
        'datum' : datumVrijeme,
        'KorisnikId' : Authorization.userId,
        'AutomobilId' : widget.automobilId
      };
      await _testDriveProvider.insert(request);
      Navigator.of(context).pop({
        "ok"
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }

}