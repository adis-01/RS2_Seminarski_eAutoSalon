import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InsertNewScreenEditor extends StatefulWidget {
  const InsertNewScreenEditor({super.key});

  @override
  State<InsertNewScreenEditor> createState() => _InsertNewScreenEditorState();
}

class _InsertNewScreenEditorState extends State<InsertNewScreenEditor> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return EditorMasterScreen(
        title: 'Novi članak',
        body: Container(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
              width: 650,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white70, borderRadius: BorderRadius.circular(12)),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildInfo(),
                    const SizedBox(height: 25),
                    buildInputs(),
                    const SizedBox(height: 15),
                    const Divider(thickness: 0.3, color: Colors.blueGrey),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF248BD6)),
                        onPressed: (){
                          saveData();
                        }, child: const Text("Spasi", style: TextStyle(color: Colors.white, fontSize: 17))),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'naslov',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                        FormBuilderValidators.maxLength(context, 50, errorText: 'Maksimalno 50 znakova')
                        ]),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: 'Naslov',
                        labelStyle: const TextStyle(color: Colors.blueGrey)
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 53,
                    child: FormBuilderDropdown(
                      name: 'tip',
                      initialValue: 'Kolumna',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: 'Tip članka'
                      ),
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
                    child: FormBuilderTextField(
                      name: 'sadrzaj',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: 'Sadržaj članka',
                        labelStyle: const TextStyle(color: Colors.blueGrey)
                      ),
                      minLines: 4,
                      maxLines: null,
                    ),
                  )
                ],
              );
  }

  Container buildInfo() {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.4, color: Colors.blueGrey), borderRadius: BorderRadius.circular(5)),
                child: const Text(
                    "INFO: Popunite sva polja, a zatim kliknite na dugme Spasi",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontSize: 14)),
              );
  }

  Future<void> saveData() async{
    try {
      if(_formKey.currentState!=null){
        if(_formKey.currentState!.saveAndValidate()){
          print(_formKey.currentState!.value);
        }
      }
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }

}
