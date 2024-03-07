
// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/providers/user_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';


class EditProfile extends StatefulWidget {
  User user;
  EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String,dynamic> _initialValue = {};
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider=context.read<UserProvider>();
    _initialValue={
      'firstName' : widget.user.firstName ?? "",
      'lastName' : widget.user.lastName ?? "",
      'username' : Authorization.username,
      'email' : widget.user.email ?? ""
    };
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Korisnik', 
    body: Center(
      child: SingleChildScrollView(
          child: FormBuilder(
            initialValue: _initialValue,
            key: _formKey,
            child: Column(
              children: [
                const Text("UREĐIVANJE PODATAKA", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, letterSpacing: 1, fontSize: 16),),
                buildFirstName(),
                buildLastName(),
                buildUsername(),
                buildEmail(),
                buildButton()
              ],
            ),
          ),
      ),
    )
    );
  }

  GestureDetector buildButton() {
    return GestureDetector(
                onTap: (){
                  saveData();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black87
                  ),
                  child: const Text("SAČUVAJ", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.5, fontSize: 15),),
                ),
              );
  }

  Padding buildFirstName() {
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'firstName',
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black38)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                    (value){
                      if(value != null && value.startsWith(" ")){
                        return 'Započnite slovom';
                      }
                      else{
                        return null;
                      }
                    }
                  ]),
                ),
              );
  }

  Padding buildLastName() {
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'lastName',
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black38)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                    (value){
                      if(value != null && value.startsWith(" ")){
                        return 'Započnite slovom';
                      }
                      else{
                        return null;
                      }
                    }
                  ]),
                ),
              );
  }

  Padding buildUsername() {
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'username',
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black38)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Polje obavezno';
                    }
                    else if(value.contains(":")){
                      return 'Dvotačka zabranjena';
                    }
                    else if(value.contains(" ")){
                      return 'Prazan prostor nije dozvoljen';
                    }
                    else {
                      return null;
                    }
                  }
                ),
              );
  }

  Padding buildEmail() {
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'email',
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black38)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                    (value){
                      if(value!=null && value.contains(" ")){
                        return 'Prazan prostor nije dozvoljen';
                      }
                      else{
                        return null;
                      }
                    },
                    FormBuilderValidators.email(context,errorText: 'Unesite validan format'),
                  ]),
                ),
              );
  }
  
  Future<void> saveData() async{
    try {
      if(_formKey.currentState!=null){
        if(_formKey.currentState!.saveAndValidate()){
          await _userProvider.update(widget.user.korisnikId!, _formKey.currentState!.value);
          Authorization.username = _formKey.currentState!.value['username'];
          MyDialogs.showSuccess(context, 'Uspješno uređivanje podataka', () { 
            Navigator.of(context).pop();
            Navigator.of(context).pop({
              "ok"
            });
          });
        }
      }
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
