// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:eautosalon_mobile/screens/insert_code_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  bool isLoading = false;
  bool obscure = true;
  final _formKey = GlobalKey<FormBuilderState>();
  late UserProvider _userProvider;
  File? _image;
  String? _base64image;
  String hint = "Dodirnite za upload slike";

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
          body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black87,),)
            :
           Center(
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Row(children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black87,
                            size: 25,
                          )),
                      const SizedBox(width: 15),
                      const Text("Kreirajte svoj račun",
                          style: TextStyle(
                              color: Colors.black87,
                              letterSpacing: 1.2,
                              fontSize: 19,
                              fontWeight: FontWeight.w500)),
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
                    //slika
                    buildImagePicker(),
                    GestureDetector(
                      onTap: () async{
                        try {
                          if (_formKey.currentState != null) {
                          if (_formKey.currentState!.saveAndValidate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Map<String, dynamic> map =
                                Map.from(_formKey.currentState!.value);
                            if (_base64image != "") {
                              map['slikaBase64'] = _base64image;
                            }
                            var korisnik =  await _userProvider.insert(map);
                            MyDialogs.showSuccess(context, 'Uspješno ste registrovani', () { 
                              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => InsertCode(email: korisnik.email!)));
                            });
                          }
                        }
                        } catch (e) {
                          setState(() {
                            isLoading=false;
                          });
                          MyDialogs.showError(context, e.toString());
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.black87, Colors.grey])),
                        child: const Text(
                          "REGISTRACIJA",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Padding buildImagePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: FormBuilderField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: 'slikaBase64',
        builder: (field) {
          return SizedBox(
            width: double.infinity,
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black54)),
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.blueGrey),
                  suffixIcon: const Icon(
                    Icons.upload,
                    color: Colors.black54,
                  ),
                  errorText: field.errorText),
              onTap: uploadImage,
            ),
          );
        },
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
          errorStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black54)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: 'Ime',
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
          FormBuilderValidators.minLength(context, 2,
              errorText: 'Min. 2 slova'),
          FormBuilderValidators.maxLength(context, 25,
              errorText: 'Max. 25 slova')
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
          errorStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black54)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: 'Prezime',
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
          FormBuilderValidators.minLength(context, 2,
              errorText: 'Min. 2 slova'),
          FormBuilderValidators.maxLength(context, 35,
              errorText: 'Max. 35 slova')
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
            errorStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black54)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            fillColor: Colors.grey[200],
            filled: true,
            hintText: 'Lozinka',
            hintStyle: const TextStyle(color: Colors.blueGrey),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscure = !obscure;
                });
              },
              icon: Icon(
                obscure ? Icons.visibility : Icons.visibility_off,
                color: Colors.black54,
              ),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Polje obavezno';
          } else if (value.contains(":")) {
            return 'Dvotačka zabranjena';
          } else if (value.contains(" ")) {
            return 'Prazno polje zabranjeno';
          } else {
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
          errorStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black54)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: 'Email',
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
          FormBuilderValidators.email(context,
              errorText: 'Format mail adrese neispravan')
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
          errorStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black54)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red)),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: 'Korisničko ime',
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Polje obavezno';
          } else if (value.contains(":")) {
            return 'Dvotačka zabranjena';
          } else if (value.length < 3) {
            return 'Min. 3 znaka';
          } else if (value.length > 15) {
            return 'Max. 3 znaka';
          } else if (value.contains(" ")) {
            return 'Prazno polje zabranjeno';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Future<void> uploadImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      _base64image = base64Encode(_image!.readAsBytesSync());
      setState(() {
        hint = _image!.path;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Canceled',
        textAlign: TextAlign.center,
      )));
    }
  }
}
