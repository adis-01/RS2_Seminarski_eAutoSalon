import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  bool obscure = true;
  final _formKey = GlobalKey<FormBuilderState>();
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
         return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 25,)),
                    const SizedBox(width: 15),
                    const Text(
                      "Kreirajte svoj račun", 
                    style: TextStyle(color: Colors.black87, letterSpacing: 1.2, fontSize: 19, fontWeight: FontWeight.w500)
                    ),
                  ]),
                  const SizedBox(height: 10),
                  //ime
                 buildFirstName(),
                  //prezime
                  buildLastName(),
                  //username
                  buildUsername(),
                  //email
                  buildEmail(),
                  //password
                  buildPassword(),
                  GestureDetector(
                    onTap: (){
                      if(_formKey.currentState!=null){
                        if(_formKey.currentState!.saveAndValidate()){
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black87,
                            Colors.grey
                          ]
                        )
                      ),
                      child: const Text("REGISTRACIJA",
                      textAlign: TextAlign.center,
                       style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.w400, fontSize: 15),),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  Padding buildFirstName() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'FirstName',
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Ime',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                    FormBuilderValidators.minLength(context, 2, errorText: 'Min. 2 slova'),
                    FormBuilderValidators.maxLength(context, 25, errorText: 'Max. 25 slova')
                  ]),
                ),
              );
  }

  Padding buildLastName() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'LastName',
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Prezime',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                    FormBuilderValidators.minLength(context, 2, errorText: 'Min. 2 slova'),
                    FormBuilderValidators.maxLength(context, 35, errorText: 'Max. 35 slova')
                  ]),
                ),
              );
  }

  Padding buildPassword() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'Password',
                  cursorColor: Colors.grey,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Lozinka',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(obscure ? Icons.visibility : Icons.visibility_off, color: Colors.black54,),
                    )
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Polje obavezno';
                    }
                    else if(value.contains(":")){
                      return 'Dvotačka zabranjena';
                    }
                    else if(value.contains(" ")){
                      return 'Prazno polje zabranjeno';
                    }
                    else{
                      return null;
                    }
                  },
                ),
              );
  }

  Padding buildEmail() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'Email',
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                    FormBuilderValidators.email(context, errorText: 'Format mail adrese neispravan')
                  ]),
                ),
              );
  }

  Padding buildUsername() {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'Username',
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.red)
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Korisničko ime',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Polje obavezno';
                    }
                    else if(value.contains(":")){
                      return 'Dvotačka zabranjena';
                    }
                    else if(value.length < 3){
                      return 'Min. 3 znaka';
                    }
                    else if(value.length>15){
                      return 'Max. 3 znaka';
                    }
                    else if(value.contains(" ")){
                      return 'Prazno polje zabranjeno';
                    }
                    else{
                      return null;
                    }
                  },
                ),
              );
  }

}


