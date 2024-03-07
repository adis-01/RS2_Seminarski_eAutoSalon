// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/screens/user_profile_screen.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/dialogs.dart';

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
    _initialValue = {
      'firstName' : widget.user.firstName,
      'lastName' : widget.user.lastName,
      'username' : widget.user.username,
      'email' : widget.user.email
    };
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[300],
      child: SingleChildScrollView(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(15),
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.edit, size: 25, color: Colors.blueGrey),
                    IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.blueGrey,
                        )),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    cursorColor: Colors.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'firstName',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Polje je obavezno'),
                      (value){
                        if(value != null && value.startsWith(" ")){
                          return 'Započnite slovom';
                        }
                        else{
                          return null;
                        }
                      }
                    ]),
                    decoration: InputDecoration(
                      labelText: 'Ime',
                       labelStyle: const TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    cursorColor: Colors.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'lastName',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Polje je obavezno'),
                      (value){
                        if(value != null && value.startsWith(" ")){
                          return 'Započnite slovom';
                        }
                        else{
                          return null;
                        }
                      }
                    ]),
                    decoration: InputDecoration(
                      labelText: 'Prezime',
                       labelStyle: const TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    cursorColor: Colors.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'username',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Polje je obavezno'),
                      (value){
                        if(value!=null && value.contains(":")){
                          return "Dvotačka nije dozvoljena";
                        }
                        else if(value!=null && value.contains(" ")){
                          return 'Prazno polje nije dozvoljeno';
                        }
                        else{
                          return null;
                        }
                      }
                    ]),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    cursorColor: Colors.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'email',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Polje je obavezno'),
                      FormBuilderValidators.email(context, 
                                              errorText: 'Neispravan format'),
                      (value){
                        if(value!=null && value.contains(" ")){
                          return 'Prazno polje nije dozvoljeno';
                        }
                        else{
                          return null;
                        }
                      }
                    ]),
                    decoration: InputDecoration(
                      labelText: 'Email',
                       labelStyle: const TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 40,
                        child: MaterialButton(
                          color: Colors.blueGrey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.all(10),
                            onPressed: () async {
                              if (_formKey.currentState != null) {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  try {
                                    await _userProvider.update(widget.user.korisnikId!, _formKey.currentState!.value);
                                  Authorization.username = _formKey.currentState!.value['username'];
                                  CustomDialogs.showSuccess(context, 'Uspješno uređivanje podataka', () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (builder) => const UserProfileScreen())
                                      );
                                   });
                                  } catch (e) {
                                    CustomDialogs.showError(context, e.toString());
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Spasi',
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
