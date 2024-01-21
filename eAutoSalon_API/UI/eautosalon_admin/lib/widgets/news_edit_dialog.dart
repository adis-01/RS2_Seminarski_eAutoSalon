// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/news_provider.dart';
import 'package:eautosalon_admin/screens/news_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/news.dart';

class EditNewsDialog extends StatefulWidget {
  News news;
  EditNewsDialog({super.key, required this.news});

  @override
  State<EditNewsDialog> createState() => _EditNewsDialogState();
}

class _EditNewsDialogState extends State<EditNewsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> initialValue = {};
  late NewsProvider _newsProvider;

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    initialValue = {
      'sadrzaj': widget.news.sadrzaj,
      'naslov': widget.news.naslov
    };
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[300],
      child: Container(
        width: 700,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.edit, color: Colors.blueGrey, size: 25),
                  IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close,
                          color: Colors.blueGrey, size: 25))
                ],
              ),
              const SizedBox(height: 20),
              FormBuilder(
                key: _formKey,
                initialValue: initialValue,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'naslov',
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Naslov'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'Polje je obavezno')
                        ]),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: FormBuilderTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'sadrzaj',
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Sadržaj'),
                        maxLines: null,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'Polje je obavezno')
                        ]),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 42,
                child: MaterialButton(
                  color: Colors.blueGrey,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    saveData();
                  },
                  child: const Text("Spasi", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveData() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.saveAndValidate()) {
        try {
          await _newsProvider.update(
              widget.news.novostiId!, _formKey.currentState!.value);
          CustomDialogs.showSuccess(context, 'Uspješno sačuvane promjene', () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => const NewsScreen()));
          });
        } catch (e) {
          CustomDialogs.showError(context, e.toString());
        }
      }
    }
  }
}
