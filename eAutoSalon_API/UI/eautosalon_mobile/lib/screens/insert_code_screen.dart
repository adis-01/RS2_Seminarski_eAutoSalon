// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/providers/user_provider.dart';
import 'package:eautosalon_mobile/screens/login_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class InsertCode extends StatefulWidget {
  final String email;
  const InsertCode({super.key, required this.email});

  @override
  State<InsertCode> createState() => _InsertCodeState();
}

class _InsertCodeState extends State<InsertCode> {

  bool isLoading = false;
  late UserProvider _userProvider;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _userProvider=context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Scaffold(
        backgroundColor: Colors.grey[300],
        body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black87,),) 
      : Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Verifikujte Vašu Email Adresu",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    wordSpacing: 2),
              ),
              const SizedBox(height: 15),
              Text(
                "Unesite kod koji ste dobili na ${widget.email}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 1,
                    color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              buildContainerNumber(),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildButton() {
    return GestureDetector(
      onTap: ()  async{
        if(_formKey.currentState!=null){
          if(_formKey.currentState!.saveAndValidate()){
            setState(() {
              isLoading=true;
            });
            saveData();
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black87, Colors.grey])),
        child: const Text(
          "POTVRDI",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  FormBuilder buildContainerNumber() {
    return FormBuilder(
      key: _formKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey[900]),
        child: FormBuilderTextField(
          name: 'Token',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.minLength(context, 4, errorText: 'Kod se sastoji od 4 broja'),
            FormBuilderValidators.maxLength(context, 4, errorText: 'Kod se sastoji od 4 broja'),
            FormBuilderValidators.numeric(context, errorText: 'Samo brojevi')
          ]),
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 8),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: '0000',
            errorStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500, wordSpacing: 1.5, color: Colors.redAccent),
            hintStyle: TextStyle(
                fontSize: 18, letterSpacing: 8, color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
  
  Future<void> saveData() async{
    try {
      String vrijednost = _formKey.currentState!.value['Token'];
      int token = int.parse(vrijednost);
      await _userProvider.verify({
        'Email' : widget.email,
        'Token' : token
      });
      MyDialogs.showSuccess(context, 'Uspješno ste verifikovani, molimo prijavite se', () {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
       });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      MyDialogs.showError(context, e.toString());
    }
  }
}
