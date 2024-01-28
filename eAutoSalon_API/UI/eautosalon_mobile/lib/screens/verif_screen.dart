import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  String email = "";
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
            child: Column(
              children: [
                buildHeader(context),
                const SizedBox(height: 30),
                Icon(Icons.verified_user_rounded, size: 40, color: Colors.blue[400],),
                const SizedBox(height: 15),
                const Text("Unesite email adresu na koju ćete dobiti verifikacijski kod",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),),
                buildInputField(context),
                buildButton()
              ],
            ),
          )
        ),
    );
  }

  GestureDetector buildButton() {
    return GestureDetector(
                onTap: (){
                  if(_formKey.currentState!=null){
                    if(_formKey.currentState!.saveAndValidate()){
                      print(_formKey.currentState!.value);
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.black,
                        Colors.grey
                      ]
                    ),
                  ),
                  child: const Text("POŠALJI", textAlign: TextAlign.center,style: TextStyle(fontSize: 17,letterSpacing: 1, color: Colors.white,),),
                ),
              );
  }

  FormBuilder buildInputField(BuildContext context) {
    return FormBuilder(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: FormBuilderTextField(
                      cursorColor: Colors.grey,
                      textAlign: TextAlign.center,
                      name: 'emailAdresa',
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        errorStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        hintText: 'Email adresa...',
                        hintStyle: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w400)
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.email(context, errorText: 'Neispravno email polje')
                      ]),
                      onChanged: (value) {
                        setState(() {
                          value = email;
                        });
                      },
                    ),
                  ),
              );
  }

  Row buildHeader(BuildContext context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: const Icon(Icons.arrow_back_ios, size: 25, color: Colors.black87,)),
                   const SizedBox(width: 15),
                  const Text(
                    "Verifikacija", 
                  style: TextStyle(color: Colors.black87, letterSpacing: 1.2, fontSize: 19, fontWeight: FontWeight.w500)
                  ),
                ],
              );
  }
}