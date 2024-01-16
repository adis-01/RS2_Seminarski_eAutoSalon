
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EditNewsDialog extends StatefulWidget {
  const EditNewsDialog({super.key});

  @override
  State<EditNewsDialog> createState() => _EditNewsDialogState();
}

class _EditNewsDialogState extends State<EditNewsDialog> {

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String,dynamic> initialValue = {};

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[300],
      child: Container(
        width: 700,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.edit, color: Color(0xFF248BD6), size: 25),
                IconButton(
                  splashRadius: 20,
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  icon: const Icon(Icons.close, color: Color(0xFF248BD6), size: 25))
              ],
            ),
            const SizedBox(height: 20),
            FormBuilder(
              key: _formKey,
              child: SizedBox(
                width: double.infinity,
                child: FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'sadrzaj',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    labelText: 'Sadržaj'
                  ),
                  maxLines: null,
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required(context, errorText: 'Polje je obavezno')]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 35,
              runSpacing: 10,
              children: [
                MaterialButton(
                  color: const Color(0xFF248BD6),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                child: const Text("Nazad", style: TextStyle(color: Colors.white)),
                ),
                MaterialButton(
                  color: const Color(0xFF248BD6),
                  onPressed: (){
                    saveData();
                  },
                child: const Text("Spasi", style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveData() async{
    try {
      if(_formKey.currentState!=null){
        if(_formKey.currentState!.saveAndValidate()){
        }
      }
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }

}