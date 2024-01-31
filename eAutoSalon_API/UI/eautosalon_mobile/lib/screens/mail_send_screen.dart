// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/providers/contact_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class MailSendScreen extends StatefulWidget {
  const MailSendScreen({super.key});

  @override
  State<MailSendScreen> createState() => _MailSendScreenState();
}

class _MailSendScreenState extends State<MailSendScreen> {

  late ContactProvider _contactProvider;
  bool isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _contactProvider=context.read<ContactProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: '',
      body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black87,),)
      : Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [ Icon(Icons.mail, size: 25, color: Colors.black54,) ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Pošaljite mail ukoliko imate neko pitanje, primjedbu i slično",textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'FullName',
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'Vaše ime i prezime',
                        hintStyle: const TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.white60, width: 2)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.black, width: 2)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        errorStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje obavezno')
                      ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'Mail',
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'Vaša mail adresa',
                        hintStyle: const TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.white60, width: 2)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.black, width: 2)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        errorStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                        FormBuilderValidators.email(context, errorText: 'Neispravan format')
                      ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'Content',
                      cursorColor: Colors.grey,
                      minLines: 2,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Sadržaj...',
                        hintStyle: const TextStyle(color: Colors.blueGrey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.white60, width: 2)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.black, width: 2)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        errorStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                        FormBuilderValidators.maxLength(context, 200, errorText: 'Max. 200 znakova')
                      ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      saveData();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black87,
                            Colors.grey
                          ]
                        )
                      ),
                      child: const Text("POŠALJI", textAlign: TextAlign.center,style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1),),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      )
    );
  }

  Future<void> saveData() async{
    try {
      if(_formKey.currentState!=null){
        if(_formKey.currentState!.saveAndValidate()){
          setState(() {
            isLoading=true;
          });
          await _contactProvider.sendMail(_formKey.currentState!.value);
          MyDialogs.showSuccess(context, 'Uspješno poslan mail', () { 
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        }
      }
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }

}