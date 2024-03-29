

// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
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
      floatingEnabled: false,
      title: 'Korisnički profil',
       body: isLoading ?
        const Center(child: CircularProgressIndicator(color: Colors.blueGrey,)) 
        : Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBack(context),
                const SizedBox(height: 10),
                buildUserProfileColumn()
              ],
            ),
          )
        )
      );
  }

  Container buildUserProfileColumn() {
    return Container(
                    padding: const EdgeInsets.all(10),
                    width: 550,
                    decoration:const BoxDecoration(
                      color: Colors.white38,
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      )
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 270,
                          child: user.slika != "" ? fromBase64String(user.slika!) : Image.asset("assets/images/no_profile_pic.png"),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Registrovan od ${user.registrationDate}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.blueGrey), textAlign: TextAlign.start,),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 400,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white70,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Email", style: TextStyle(fontSize: 15, color: Colors.blueGrey, letterSpacing: 1),),
                              Text(user.email ?? "no_mail@unknown.com",
                           textAlign: TextAlign.center,
                           style: const TextStyle(fontSize: 16, letterSpacing: 1, color: Colors.black87, fontWeight: FontWeight.w400),
                           ),
                            ],
                          )
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white70
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Ime i prezime", style: TextStyle(fontSize: 15, color: Colors.blueGrey, letterSpacing: 1),),
                              Text("${user.firstName ?? "null"} ${user.lastName ?? "null"}",
                              style: const TextStyle(fontSize: 16, letterSpacing: 1, color: Colors.black87, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white70
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Username", style: TextStyle(fontSize: 15, color: Colors.blueGrey, letterSpacing: 1),),
                              const SizedBox(height: 5),
                              Text(user.username ?? "null",
                              style: const TextStyle(fontSize: 16, letterSpacing: 1, color: Colors.black87, fontWeight: FontWeight.w400),)
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 400,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black54,
                              width: 0.3
                            )
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.center,
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
                                  icon: const Icon(Icons.password, color: Colors.blueGrey),
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
                                  icon: const Icon(Icons.edit, color: Colors.blueGrey),
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
                                icon: const Icon(Icons.camera_alt, color: Colors.blueGrey)),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
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