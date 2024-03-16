import 'package:eautosalon_admin/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ChangeCarStateDialog extends StatefulWidget {
  final Automobil automobil;
  const ChangeCarStateDialog({super.key, required this.automobil});

  @override
  State<ChangeCarStateDialog> createState() => _ChangeCarStateDialogState();
}

class _ChangeCarStateDialogState extends State<ChangeCarStateDialog> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(10),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.close, size: 25, color: Colors.blueGrey,))
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("Cijena", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black54, letterSpacing: 1, fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        readOnly: true,
                        name: 'Iznos',
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: '\$${widget.automobil.formattedPrice}', 
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          suffixIcon: const Icon(Icons.attach_money, size: 18, color: Colors.black87,)
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("ID Automobila", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black54, letterSpacing: 1, fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        readOnly: true,
                        name: 'AutomobilId',
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: widget.automobil.automobilId.toString(), 
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          suffixIcon: const Icon(Icons.directions_car, size: 18, color: Colors.black87,)
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("ID Korisnika", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black54, letterSpacing: 1, fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        cursorColor: Colors.grey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'KorisnikId',
                        decoration: InputDecoration(
                          hintText: 'Unesite ID korisnika...', 
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                          suffixIcon: const Tooltip(
                            message: 'Pod sekcijom "Korisnici" u aplikaciji nađite odgovarajuće polje za odgovarajućeg korisnika',
                            child: Icon(Icons.question_mark, color: Colors.black87,),
                          )
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.integer(context,errorText: 'Samo cijeli brojevi'),
                          FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                          (value){
                            if(value!=null && value.contains(" ")){
                              return 'Prazan prostor nije dozvoljen';
                            }
                            else{
                              return null;
                            }
                          }
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(15),
                    color: Colors.blueGrey,
                    onPressed: (){
                      saveData();
                  }, child: const Text("Spasi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void saveData() {
    if(_formKey.currentState!=null){
      if(_formKey.currentState!.saveAndValidate()){
        Navigator.of(context).pop({
          'KorisnikId' : _formKey.currentState!.value['KorisnikId'],
          'AutomobilId' : widget.automobil.automobilId,
          'Iznos' : widget.automobil.cijena,
          'IsOnline' : false
        });
      }
    }
  }
}