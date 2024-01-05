
// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/users_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class EditUser extends StatefulWidget {
  User user;
  EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  late TextEditingController userId;
  late TextEditingController first;
  late TextEditingController last;
  late TextEditingController username;
  late TextEditingController email;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    userId = TextEditingController(text: widget.user.korisnikId.toString());
    first = TextEditingController(text: widget.user.firstName);
    last = TextEditingController(text: widget.user.lastName);
    email = TextEditingController(text: widget.user.email);
    username=TextEditingController(text: widget.user.username);
    _userProvider=context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Detalji korisnika ${widget.user.firstName} ${widget.user.lastName}", 
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
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.grey[350],
                          border: Border.all(color: Colors.blueGrey, width: 0.4),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Wrap(
                            spacing: 15,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              _buildInput('ID', userId, true),
                              _buildInput('Ime', first, false),
                              _buildInput('Prezime', last, false),
                             _buildInput('Email',email, true),
                             _buildInput('Username', username, false),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Divider(color: Colors.blueGrey, thickness: 0.3, indent: 15, endIndent: 15),
                          const SizedBox(height: 15),
                          _buildButton(),
                        ],
                      ),
                    ),
                  const SizedBox(height: 5),
                  Container(
                      padding: const EdgeInsets.all(15),
                      width: 500,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 0.4
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const[
                          Icon(Icons.info_outline,  color:Color(0xFF248BD6)),
                          SizedBox(height: 3),
                          Text("Popunite polja, a promjene spasite klikom na dugme - Email i ID polje se ne mogu mijenjati", style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                ],
              ),
        ),
      )
      );
  }

   Widget _buildButton() {
    return ElevatedButton(
        onPressed: () async {
          try {
            var obj = {
              'FirstName' : first.text,
              'LastName' : last.text,
              'Username' : username.text
            };
            await _userProvider.update(widget.user.korisnikId!, obj);
            CustomDialogs.showSuccess(context, 'Uspješno uređivanje podataka', () { 
              Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => const UsersScreen())
              );
            });
          } catch (e) {
            CustomDialogs.showError(context, e.toString());
          }
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(80, 40),
            backgroundColor: const Color(0xFF248BD6)),
        child: const Text('Spasi'));
  }

  Row _buildBack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          shape: const CircleBorder(),
          color: const Color(0xFF248BD6),
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


    SizedBox _buildInput(String hint, TextEditingController controller, bool readonly) {
    return SizedBox(
      width: 200,
      height: 60,
      child: TextField(
        readOnly: readonly,
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
          filled: readonly,
          fillColor: readonly ? Colors.grey[400] : null
        ),
      ),
    );
  }

}



  


  