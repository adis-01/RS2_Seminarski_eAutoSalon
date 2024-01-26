import 'package:eautosalon_mobile/providers/test_drive_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
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
    //getAvailableAppointments();
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
                const Center(child: Icon(Icons.data_array, size: 27, color: Colors.black54,))
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
                        isLoading = true;
                        termin = null;
                      });
                      getAvailableAppointments();
                    }
                    else{
                      setState(() {
                        termin = null;
                        disabledButton = true;
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
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    Icon(Icons.info, color: Colors.blue[600], size: 18,),
                    const SizedBox(height: 5),
                    const Text("Odaberite datum, zatim satnicu, te izvršite rezervaciju klikom na dugme", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Colors.black87),)
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
                        disabledButton = false;
                        termin = time;
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
        isLoading = false;
        lista = satnice;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }

}