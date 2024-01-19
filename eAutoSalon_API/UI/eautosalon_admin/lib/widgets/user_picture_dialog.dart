
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/user_profile_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../utils/dialogs.dart';

class UserPicture extends StatefulWidget {
  int korisnikId;
  UserPicture({super.key, required this.korisnikId});

  @override
  State<UserPicture> createState() => _UserPictureState();
}

class _UserPictureState extends State<UserPicture> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UserProvider _userProvider;
  String hint = "Klik za upload";
  File? _image;
  String? _base64image;


  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blueGrey,
      elevation: 15,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.all(20),
          width: 500,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.camera_alt, color: Colors.blueGrey, size: 25),
                    IconButton(
                      splashRadius: 25,
                      onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.close, color: Colors.blueGrey,size: 25)),
                  ],
                ),
                const SizedBox(height: 15),
                FormBuilderField(
                  builder: (field){
                    return InputDecorator(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Slika',
                        suffixIcon: const Icon(
                          Icons.upload,
                          color: Colors.blueGrey,
                        ),
                        errorText: field.errorText
                      ),
                      child: ListTile(
                        title: Text(
                          hint,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                        onTap: uploadImage,
                      ),
                    );
                }, 
                name: 'slika',
                validator: (value){
                  if(_image == null){
                    return 'Polje je obavezno';
                  }
                  else{
                    return null;
                  }
                },
                ),
                const SizedBox(height: 20),
                Center(child: SizedBox(width: 200, height:42, child: _buildButtons(context)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton _buildButtons(BuildContext context) {
    return 
                  MaterialButton(
                    color: Colors.blueGrey,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    onPressed: () async{
                    if(_formKey.currentState!=null){
                      if(_formKey.currentState!.saveAndValidate()){
                        Map<String,dynamic> map = Map.from(_formKey.currentState!.value);
                        map['slika'] = _base64image;
                        try {
                          await _userProvider.changePic(widget.korisnikId, map);
                          CustomDialogs.showSuccess(context, 'Uspješna promjena slike', () { 
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
                  child: const Text('Spasi', style: TextStyle(color: Colors.white, fontSize: 15),));
  }

  Future<void> uploadImage() async{
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if(result != null && result.files.single.path != null){
      _image = File(result.files.single.path!);
      _base64image = base64Encode(_image!.readAsBytesSync());
      setState(() {
        hint = result.files.single.name.toString();
      });
    }
  }

}