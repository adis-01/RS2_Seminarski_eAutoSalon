import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InsertCode extends StatefulWidget {
  final String email;
  const InsertCode({super.key, required this.email});

  @override
  State<InsertCode> createState() => _InsertCodeState();
}

class _InsertCodeState extends State<InsertCode> {
  String verifValue = "";
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController first = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Padding(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Niste dobili kod?",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Pošalji ponovo",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Text(verifValue)
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildButton() {
    return GestureDetector(
      onTap: () {
        if(_formKey.currentState!=null){
          if(_formKey.currentState!.saveAndValidate()){
            print (_formKey.currentState!.value);
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
          name: 'verifikacijskiKod',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.minLength(context, 4, errorText: 'Kod se sastoji od 4 broja'),
            FormBuilderValidators.maxLength(context, 4, errorText: 'Kod se sastoji od 4 broja'),
            FormBuilderValidators.numeric(context, errorText: 'Samo brojevi')
          ]),
          controller: first,
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
}
