// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/login_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PasswordChange extends StatefulWidget {
  int korisnikId;
  PasswordChange({super.key, required this.korisnikId});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscure = true;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.password,
                      size: 25,
                      color: Colors.blueGrey,
                    ),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: Colors.grey,
                    name: 'Stari_Pass',
                    obscureText: _obscure,
                    validator:
                      (value){
                        if(value == null || value.isEmpty){
                          return 'Polje obavezno';
                        }
                        else if(value.contains(" ")){
                          return 'Prazno polje zabranjeno';
                        }
                        else if (value.contains(":")){
                          return 'Dvotačka zabranjena';
                        }
                        else{
                          return null;
                        }
                      },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      labelText: 'Trenutna lozinka',
                      suffix: IconButton(
                          color: Colors.blueGrey,
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: _obscure
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: Colors.grey,
                    name: 'Novi_Pass',
                    obscureText: _obscure,
                    validator:(value){
                        if(value == null || value.isEmpty){
                          return 'Polje obavezno';
                        }
                        else if(value.contains(" ")){
                          return 'Prazno polje zabranjeno';
                        }
                        else if (value.contains(":")){
                          return 'Dvotačka zabranjena';
                        }
                        else{
                          return null;
                        }
                      },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      labelText: 'Nova lozinka',
                      suffix: IconButton(
                          color: Colors.blueGrey,
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: _obscure
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    cursorColor: Colors.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'Novi_Pass_Repeat',
                    obscureText: _obscure,
                    validator: (value) {
                      final newPass =
                          _formKey.currentState?.fields['Novi_Pass']?.value;
                      if (newPass != value) {
                        return 'Passwordi se ne poklapaju';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      labelText: 'Ponovite novu lozinku',
                      suffix: IconButton(
                          color: Colors.blueGrey,
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: _obscure
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: SizedBox(
                    height: 42,
                    width: 200,
                    child: MaterialButton(
                        color: Colors.blueGrey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(10),
                        onPressed: () async {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.saveAndValidate()) {
                              try {
                                await _userProvider.changePass(
                                    widget.korisnikId,
                                    _formKey.currentState!.value);
                                CustomDialogs.showSuccess(context,
                                    'Uspješna promjena lozinke, logirajte se ponovno',
                                    () {
                                  Authorization.username = "";
                                  Authorization.password = "";
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (builder) =>
                                          const LoginScreen()));
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
