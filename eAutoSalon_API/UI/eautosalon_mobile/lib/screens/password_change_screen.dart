// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/providers/user_provider.dart';
import 'package:eautosalon_mobile/screens/login_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PassChange extends StatefulWidget {
  int korisnikId;
  PassChange({super.key, required this.korisnikId});

  @override
  State<PassChange> createState() => _PassChangeState();
}

class _PassChangeState extends State<PassChange> {
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
    return MyAppBar(
      title: 'LOZINKA',
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "PROMJENA LOZINKE",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    letterSpacing: 1),
              ),
              const SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  margin:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildOldPass(),
                        buildNewPass(),
                        buildNewPassRepeated(),
                      ],
                    ),
                  )),
              buildButton()
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildButton() {
    return GestureDetector(
      onTap: () async {
        try {
          if (_formKey.currentState != null) {
            if (_formKey.currentState!.saveAndValidate()) {
              await _userProvider.changePass(
                  widget.korisnikId, _formKey.currentState!.value);
              MyDialogs.showSuccess(
                  context, 'Lozinka promijenjena, molimo prijavite se ponovo',
                  () {
                Authorization.username = "";
                Authorization.password = "";
                Authorization.userId = null;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => const LoginScreen()));
              });
            }
          }
        } catch (e) {
          MyDialogs.showError(context, e.toString());
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black87),
        child: const Text(
          "SAČUVAJ",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Padding buildNewPassRepeated() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: 'Novi_Pass_Repeat',
        obscureText: obscure,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: Colors.white70,
            hintText: 'Ponovite novu lozinku',
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
          final newPass = _formKey.currentState?.fields['Novi_Pass']?.value;
          if (newPass != value) {
            return 'Passwordi se ne poklapaju';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Padding buildNewPass() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: 'Novi_Pass',
        obscureText: obscure,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: Colors.white70,
            hintText: 'Nova lozinka',
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
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context, errorText: 'Polje obavezno')
        ]),
      ),
    );
  }

  Padding buildOldPass() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: 'Stari_Pass',
        obscureText: obscure,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            fillColor: Colors.white70,
            hintText: 'Trenutna lozinka',
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
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context, errorText: 'Polje obavezno')
        ]),
      ),
    );
  }
}
