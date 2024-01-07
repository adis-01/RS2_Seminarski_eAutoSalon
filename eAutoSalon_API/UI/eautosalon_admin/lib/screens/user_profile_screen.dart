
import 'dart:convert';
import 'package:eautosalon_admin/screens/edit_user_screen.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:eautosalon_admin/widgets/password_change.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserProfileScreen extends StatefulWidget {
  String username;
  UserProfileScreen({super.key, required this.username});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  bool isLoading = true;
  late String firstName;
  late String lastName;
  late String email;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'User profile',
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
                    width: 450,
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
                          height: 200,
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
                          child: Image.asset("assets/images/employee.png", ),
                        ),
                        const SizedBox(height: 15),
                        Text('$firstName $lastName',  textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey),
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 0.3, color: Colors.blueGrey, indent: 40, endIndent: 40),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.mail, size: 25, color: Colors.blueGrey,),
                            const SizedBox(width: 15),
                            Text(email, style: const TextStyle(fontSize: 18, color: Color(0xFF248BD6), fontStyle: FontStyle.italic, fontWeight: FontWeight.w600))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.person_outline, size: 25, color: Colors.blueGrey),
                            const SizedBox(width: 15),
                            Text(widget.username, style: const TextStyle(fontSize: 18, color: Color(0xFF248BD6), fontStyle: FontStyle.italic, fontWeight: FontWeight.w600))
                          ],
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
                                    return PasswordChange();
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
                                  
                                },
                                icon: const Icon(Icons.edit, color: Color(0xFF248BD6)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  );
  }

  Future<void> fetchData() async{
    var url = "https://localhost:7173/Korisnici/UserProfile?username=${widget.username}";
    var uri = Uri.parse(url);
    String username = Authorization.username ?? "";
    String pass = Authorization.password ?? "";
    var creds = "Basic ${base64Encode(utf8.encode('$username:$pass'))}";
    var headers = {
      "Content-Type" : "application/json",
      "Authorization" : creds
    };
   var req = await http.get(uri, headers: headers);
   if(req.statusCode == 200){
    var obj = jsonDecode(req.body);
    setState(() {
      firstName = obj['firstName'];
      lastName = obj['lastName'];
      email = obj['email'];
      isLoading=false;
    });
   }
   else{
    throw Exception('Error: ${jsonDecode(req.body)}');
   }
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
            Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => const HomePageScreen())
            );
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