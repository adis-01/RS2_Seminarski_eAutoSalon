// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:eautosalon_admin/providers/comment_provider.dart';
import 'package:eautosalon_admin/providers/news_provider.dart';
import 'package:eautosalon_admin/screens/news_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class InsertNewScreenEditor extends StatefulWidget {
  const InsertNewScreenEditor({super.key});

  @override
  State<InsertNewScreenEditor> createState() => _InsertNewScreenEditorState();
}

class _InsertNewScreenEditorState extends State<InsertNewScreenEditor> {
  late int userID;
  bool isLoading = true;
  late NewsProvider _newsProvider;
  late KomentarProvider _commentProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  String hint = "Klik za upload";
  File? image;
  String? _base64image;

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    _commentProvider = context.read<KomentarProvider>();
    loadId();
  }

  @override
  Widget build(BuildContext context) {
    return EditorMasterScreen(
        title: 'Novi članak',
        body: Container(
          padding: const EdgeInsets.all(25),
          child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.blueGrey,)
                  : SingleChildScrollView(
                      child: Container(
                        width: 650,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(12)),
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildInfo(),
                              const SizedBox(height: 25),
                              buildInputs(),
                              const SizedBox(height: 15),
                              const Divider(
                                  thickness: 0.3, color: Colors.blueGrey),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: 250,
                                child: MaterialButton(
                                   color: Colors.blueGrey,
                                   padding: const EdgeInsets.all(15),
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    onPressed: () {
                                      saveData();
                                    },
                                    child: const Text("Spasi",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17))),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
        ),
        isHomePage: false);
  }

  Wrap buildInputs() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        SizedBox(
          width: 300,
          child: FormBuilderTextField(
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: 'naslov',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context,
                  errorText: 'Polje obavezno'),
              FormBuilderValidators.maxLength(context, 50,
                  errorText: 'Maksimalno 50 znakova')
            ]),
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Naslov',
                labelStyle: const TextStyle(color: Colors.blueGrey)),
          ),
        ),
        SizedBox(
          width: 300,
          height: 53,
          child: FormBuilderDropdown(
            name: 'tip',
            initialValue: 'Kolumna',
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Tip članka'),
            items: const [
              DropdownMenuItem(
                value: 'Kolumna',
                child: Text('Kolumna'),
              ),
              DropdownMenuItem(
                value: 'Recenzija',
                child: Text('Recenzija'),
              ),
              DropdownMenuItem(
                value: 'Novost',
                child: Text('Novost'),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FormBuilderField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: 'slikaBase64',
            builder: (field) {
              return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Slika',
                    suffixIcon: const Icon(
                      Icons.upload,
                      color: Colors.blueGrey,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      hint,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey),
                    ),
                    onTap: uploadImage,
                  ));
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FormBuilderTextField(
            cursorColor: Colors.grey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(context, 50,
                  errorText: 'Minimalno 50 znakova')
            ]),
            name: 'sadrzaj',
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Sadržaj članka',
                labelStyle: const TextStyle(color: Colors.blueGrey)),
            minLines: 4,
            maxLines: null,
          ),
        ),
      ],
    );
  }

  Container buildInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(5)),
      child: const Text(
          "INFO: Popunite sva polja, a zatim kliknite na dugme Spasi",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
              fontSize: 14)),
    );
  }

  Future<void> saveData() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.saveAndValidate()) {
        Map<String, dynamic> map = Map.from(_formKey.currentState!.value);
        map['slikaBase64'] = _base64image;
        map['KorisnikId'] = userID;
        try {
          setState(() {
            isLoading = true;
          });
          await _newsProvider.insert(map);
          setState(() {
            isLoading=false;
          });
          CustomDialogs.showSuccess(context, 'Uspješno dodan novi članak', () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => const NewsScreen()));
          });
        } catch (e) {
          setState(() {
            isLoading=false;
          });
          CustomDialogs.showError(context, e.toString());
        }
      }
    }
  }

  Future<void> uploadImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      image = File(result.files.single.path!);
      _base64image = base64Encode(image!.readAsBytesSync());
      setState(() {
        hint = result.files.single.name.toString();
      });
    }
  }

  Future<void> loadId() async {
    try {
      var data = await _commentProvider.getUserId();
      setState(() {
        userID = data;
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
