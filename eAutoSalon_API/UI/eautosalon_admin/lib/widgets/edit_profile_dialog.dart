// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/screens/user_profile_screen.dart';
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
      backgroundColor: Colors.grey[200],
      child: SingleChildScrollView(
        child: Container(
          width: 450,
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
                    const Icon(Icons.edit, size: 25, color: Color(0xFF248BD6)),
                    IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                          color: Color(0xFF248BD6),
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'firstName',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Polje je obavezno')
                    ]),
                    decoration: const InputDecoration(
                      labelText: 'Ime',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'lastName',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Polje je obavezno')
                    ]),
                    decoration: const InputDecoration(
                      labelText: 'Prezime',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'username',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Polje je obavezno')
                    ]),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'email',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Polje je obavezno'),
                      FormBuilderValidators.email(context, 
                                              errorText: 'Neispravan format')
                    ]),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 50,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Poništi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15))),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.saveAndValidate()) {
                              try {
                                await _userProvider.update(widget.user.korisnikId!, _formKey.currentState!.value);
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
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
