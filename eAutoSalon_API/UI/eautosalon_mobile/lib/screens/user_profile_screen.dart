// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/providers/user_provider.dart';
import 'package:eautosalon_mobile/screens/edit_profile_screen.dart';
import 'package:eautosalon_mobile/screens/history_user_comments.dart';
import 'package:eautosalon_mobile/screens/history_user_reviews.dart';
import 'package:eautosalon_mobile/screens/history_user_testdrives.dart';
import 'package:eautosalon_mobile/screens/login_screen.dart';
import 'package:eautosalon_mobile/screens/password_change_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  bool isLoading = true;
  late User user;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'KORISNIČKI PROFIL',
        body: 
        isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black87,),)
        :
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImageBox(),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 10),
                child: Text(
                  user.firstName ?? "null",
                  style: const TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 20),
                child: Text(
                  user.lastName ?? "null",
                  style: const TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w400,
                      fontSize: 21),
                ),
              ),
              buildEditTile(),
              buildPasswordChange(),
              Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white30),
                  child: buildExpansionTile()),
              buildLogOut()
            ],
          ),
        ));
  }

  Container buildPasswordChange() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white30),
      child: ListTile(
        leading: const Icon(
          Icons.key,
          color: Colors.black54,
          size: 25,
        ),
        title: const Text(
          "PROMJENA LOZINKE",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 1),
        ),
        trailing: IconButton(
            onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (builder) => PassChange(korisnikId:user.korisnikId!,)));
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
              size: 25,
            )),
      ),
    );
  }

  GestureDetector buildLogOut() {
    return GestureDetector(
      onTap: () {
        MyDialogs.showQuestion(context, 'Da li ste sigurni da se želite odjaviti?', () {
          Authorization.username = "";
          Authorization.password = "";
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
         });
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), 
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.black87,
                
                Colors.grey
              ]
            )
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.logout,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              "ODJAVA",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }

  ExpansionTile buildExpansionTile() {
    return ExpansionTile(
      trailing: const Icon(
        Icons.keyboard_arrow_down,
        size: 30,
        color: Colors.black87,
      ),
      collapsedShape: const RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
      ),
      leading: const Icon(
        Icons.history,
        color: Colors.black54,
        size: 25,
      ),
      title: const Text(
        "AKTIVNOST",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 1),
      ),
      children: [
        ListTile(
            leading: const Icon(
              Icons.comment,
              color: Colors.black54,
              size: 25,
            ),
            title: const Text(
              "KOMENTARI",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 1),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => HistoryComments(korisnikId: user.korisnikId!,)));
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black87,
                  size: 25,
                ))),
        ListTile(
            leading: const Icon(
              Icons.reviews,
              color: Colors.black54,
              size: 25,
            ),
            title: const Text(
              "RECENZIJE",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 1),
            ),
            trailing: IconButton(
                onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (builder) => HistoryReviews(korisnikId: user.korisnikId!,)));
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black87,
                  size: 25,
                ))),
        ListTile(
            leading: const Icon(
              Icons.directions_car,
              color: Colors.black54,
              size: 25,
            ),
            title: const Text(
              "TESTNE VOŽNJE",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 1),
            ),
            trailing: IconButton(
                onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (builder) =>  HistoryTestDrives(korisnikId: user.korisnikId!)));
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black87,
                  size: 25,
                ))),
      ],
    );
  }

  Container buildImageBox() {
    return Container(
        width: double.infinity,
        height: 220,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user.slika != "" ?
            SizedBox(
                width: 200,
                height: 120,
                child: fromBase64String(user.slika!)) : const Icon(Icons.no_photography, color: Colors.black54,size: 30,),
            const SizedBox(height: 10),
           Text(
              "Korisnik od ${user.registrationDate ?? "date null"}",
              style: const TextStyle(
                  color: Colors.black87,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            )
          ],
        ));
  }

  Center buildEditTile() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white30),
        child: ListTile(
          leading: const Icon(
            Icons.settings,
            color: Colors.black54,
            size: 25,
          ),
          title: const Text(
            "POSTAVKE PROFILA",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: 1),
          ),
          trailing: IconButton(
              onPressed: () async{
               var result = await Navigator.of(context).push(MaterialPageRoute(builder: (builder) => EditProfile(user: user,)));
               if(result!=null && result.toString().contains("ok")){
                setState(() {
                  isLoading=true;
                });
                fetchData();
               }
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black87,
                size: 25,
              )),
        ),
      ),
    );
  }
  
  Future<void> fetchData() async{
    try {
      var data = await _userProvider.fetchUserProfile();
      setState(() {
        user = data;
        isLoading=false;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
