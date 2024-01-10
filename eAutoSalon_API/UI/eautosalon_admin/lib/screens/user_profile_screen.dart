

// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/screens/login_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:eautosalon_admin/widgets/password_change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../widgets/edit_profile_dialog.dart';
import '../widgets/user_picture_dialog.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  bool isLoading = true;
  late User user;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Korisnički profil',
       body: isLoading ?
        const Center(child: CircularProgressIndicator()) 
        : Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBack(context),
                const SizedBox(height: 20),
                 Wrap(
                  spacing: 20,
                  runSpacing: 25,
                   children: [ 
                    buildUserProfileColumn(),
                   ]
                 ),
              ],
            ),
          )
        )
      );
  }

  Container buildUserProfileColumn() {
    return Container(
                    padding: const EdgeInsets.all(15),
                    width: 500,
                    decoration:const BoxDecoration(
                      color: Colors.white38,
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      )
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.1,
                              color: Colors.blueGrey
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)
                            )
                          ),
                          child: user.slika != "" ? fromBase64String(user.slika!) : Image.asset("assets/images/no_profile_pic.png"),
                        ),
                        const SizedBox(height: 20),
                        Text('${user.firstName ?? "null"} ${user.lastName ?? "null"}',  textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: 350,
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFC6CDFF),
                              border: const OutlineInputBorder(),
                              hintText: user.email ?? "null",
                              hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                              prefixIcon: const Icon(Icons.mail,size:25, color: Colors.black87,),

                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 350,
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFC6CDFF),
                              border: const OutlineInputBorder(),
                              hintText: Authorization.username ?? "null",
                              hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                              prefixIcon: const Icon(Icons.person_outline_outlined,size:25, color: Colors.black87,)
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          runSpacing: 10,
                          spacing: 35,
                          children: [
                            Tooltip(
                              message: 'Promijeni password',
                              child: IconButton(
                                splashRadius: 30,
                                iconSize: 30,
                                splashColor: const Color(0xFF83B8FF),
                                onPressed: (){
                                  showDialog(context: context, builder: (context){
                                    return PasswordChange(korisnikId: user.korisnikId!,);
                                  });
                                },
                                icon: const Icon(Icons.password, color: Color(0xFF248BD6)),
                              ),
                            ),
                            Tooltip(
                              message: 'Uredi profil',
                              child: IconButton(
                                splashRadius: 30,
                                iconSize: 30,
                                splashColor: const Color(0xFF83B8FF),
                                onPressed: (){
                                  showDialog(context: context, builder: (context){
                                    return EditProfile(user: user);
                                  });
                                },
                                icon: const Icon(Icons.edit, color: Color(0xFF248BD6)),
                              ),
                            ),
                            Tooltip(
                              message: 'Promijeni sliku',
                              child: IconButton(
                                splashRadius: 30,
                                iconSize: 30,
                                splashColor: const Color(0xFF83B8FF),
                                onPressed: (){
                                  showDialog(context: context, builder: (context){
                                    return UserPicture(korisnikId: user.korisnikId!);
                                  });
                                }, 
                              icon: const Icon(Icons.camera_alt, color: Color(0xFF248BD6))),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  );
  }

  
  
  Row _buildBack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          shape: const CircleBorder(),
          color: const Color(0xFF248BD6),
          padding: const EdgeInsets.all(15),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => const HomePageScreen())
            );
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        Tooltip(
          message: 'Izbriši profil',
          child: MaterialButton(
            shape: const CircleBorder(),
            color: const Color(0xFF248BD6),
            padding: const EdgeInsets.all(15),
            onPressed: () {
              CustomDialogs.showQuestion(context, 'Da li ste sigurni da želite izbrisati svoj profil?', () async{ 
                try {
                  await _userProvider.delete(user.korisnikId!);
                Authorization.username = "";
                Authorization.password="";
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => const LoginScreen())
                );
                } catch (e) {
                  CustomDialogs.showError(context, e.toString());
                }
              });
            },
            child: const Icon(
              Icons.delete_forever_sharp,
              size: 25,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
  
  Future<void> fetch() async{
    try {
      var data = await _userProvider.fetchData();
      setState(() {
        user = data;
        isLoading=false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }

}