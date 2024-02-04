// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/users_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class EditUser extends StatefulWidget {
  User user;
  EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _initialValue = {
      'FirstName': widget.user.firstName,
      'LastName': widget.user.lastName,
      'Username': widget.user.username,
      'Email': widget.user.email,
      'Id': widget.user.korisnikId.toString()
    };
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      floatingEnabled: false,
        title:
            "Detalji korisnika ${widget.user.firstName} ${widget.user.lastName}",
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBack(context),
                const SizedBox(height: 45),
                Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 20, bottom: 15),
                  width: 700,
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      border: Border.all(color: Colors.blueGrey, width: 0.4),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: _buildForm(context),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: 700,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 0.4),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.info_outline, color: Color(0xFF248BD6)),
                      SizedBox(height: 3),
                      Text(
                          "Popunite polja, a promjene spasite klikom na dugme - Email i ID polje se ne mogu mijenjati",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  FormBuilder _buildForm(BuildContext context) {
    return FormBuilder(
                  key: _formKey,
                  initialValue: _initialValue,
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 15,
                        runSpacing: 20,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          buildReadOnly('Id', 'ID'),
                          SizedBox(
                            width: 250,
                            child: FormBuilderTextField(
                              cursorColor: Colors.grey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              name: 'Username',
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder(),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: 'Polje obavezno'),
                                FormBuilderValidators.minLength(context, 2,
                                    errorText: 'Unesite više od 1 znaka'),
                                (value) {
                                  if (value != null && value.contains(":")) {
                                    return "Dvotačka nije dozvoljena";
                                  }
                                  else{
                                    return null;
                                  }
                                }
                              ]),
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: FormBuilderTextField(
                              cursorColor: Colors.grey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              name: 'FirstName',
                              decoration: const InputDecoration(
                                labelText: 'Ime',
                                border: OutlineInputBorder(),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: 'Polje obavezno'),
                              ]),
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: FormBuilderTextField(
                              cursorColor: Colors.grey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              name: 'LastName',
                              decoration: const InputDecoration(
                                labelText: 'Prezime',
                                border: OutlineInputBorder(),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: 'Polje obavezno'),
                              ]),
                            ),
                          ),
                         buildReadOnly('Email', 'Email'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(
                          color: Colors.blueGrey,
                          thickness: 0.3,
                          indent: 15,
                          endIndent: 15),
                      const SizedBox(height: 15),
                      _buildButton(),
                    ],
                  ),
                );
  }

  SizedBox buildReadOnly(String fieldname, String textlabel) {
    return SizedBox(
      width: 250,
      child: FormBuilderTextField(
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        readOnly: true,
        name: fieldname,
        decoration: InputDecoration(
            labelText: textlabel,
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[400]),
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          onPressed: () async {
            try {
              if(_formKey.currentState != null){
                if(_formKey.currentState!.saveAndValidate()){
                  await _userProvider.update(widget.user.korisnikId!, _formKey.currentState!.value);
                  CustomDialogs.showSuccess(context,'Uspješno uređivanje podataka', () { 
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => const UsersScreen())
                  );
                  });
                }
              }
            } catch (e) {
              CustomDialogs.showError(context, e.toString());
            }
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(80, 40),
              backgroundColor: Colors.black87),
          child: const Text('Spasi')),
    );
  }

  Row _buildBack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          shape: const CircleBorder(),
          color: Colors.blueGrey,
          padding: const EdgeInsets.all(15),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
