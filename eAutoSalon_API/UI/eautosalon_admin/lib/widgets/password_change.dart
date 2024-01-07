
import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

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
    _userProvider=context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                IconButton(
                  splashRadius: 25,
                  onPressed: (){
                  Navigator.of(context).pop();
                }, 
                icon: const Icon(Icons.close, size: 25, color: Color(0xFF248BD6),)
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    name: 'Stari_Pass',
                    obscureText: _obscure,
                    validator: FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(), 
                      labelText: 'Stara lozinka',
                      suffix: IconButton(
                        color: Colors.blueGrey,
                        onPressed: (){
                        setState(() {
                          _obscure = !_obscure;
                        });
                      }, 
                      icon: _obscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),
                      ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    name: 'Novi_Pass',
                    obscureText: _obscure,
                    validator: FormBuilderValidators.required(context, errorText: 'Polje obavezno'),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(), 
                      labelText: 'Nova lozinka',
                      suffix: IconButton(
                        color: Colors.blueGrey,
                        onPressed: (){
                        setState(() {
                          _obscure = !_obscure;
                        });
                      }, 
                      icon: _obscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),
                      ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'Novi_Pass_Repeat',
                    obscureText: _obscure,
                    validator: (value){
                      final newPass = _formKey.currentState?.fields['Novi_Pass']?.value;
                      if(newPass != value){
                        return 'Passwordi se ne poklapaju';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(), 
                      labelText: 'Ponovite novu lozinku',
                      suffix: IconButton(
                        color: Colors.blueGrey,
                        onPressed: (){
                        setState(() {
                          _obscure = !_obscure;
                        });
                      }, 
                      icon: _obscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),
                      ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 50,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: 
                    const Text('Poništi', style: TextStyle(color: Colors.white, fontSize: 15))),
                    ElevatedButton(onPressed: () async{
                      if(_formKey.currentState!=null){
                        if(_formKey.currentState!.saveAndValidate()){
                          CustomDialogs.showSuccess(context, 'Uspješno promijenjena lozinka', () {
                            Navigator.of(context).pop();
                           });
                          // try {
                            
                          // } catch (e) {
                            
                          // }
                        }
                      }
                    }, 
                    child: const Text('Spasi', style: TextStyle(color: Colors.white, fontSize: 15),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}