import 'package:eautosalon_mobile/screens/edit_profile_screen.dart';
import 'package:eautosalon_mobile/screens/history_user_comments.dart';
import 'package:eautosalon_mobile/screens/history_user_reviews.dart';
import 'package:eautosalon_mobile/screens/history_user_testdrives.dart';
import 'package:eautosalon_mobile/screens/password_change_screen.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:eautosalon_mobile/widgets/user_history_comment.dart';
import 'package:eautosalon_mobile/widgets/user_history_testdrives.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'KORISNIČKI PROFIL',
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImageBox(),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(left: 25, bottom: 10),
                child: Text(
                  "Adis",
                  style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, bottom: 20),
                child: Text(
                  "Šipković",
                  style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
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
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const PassChange()));
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
      onTap: () {},
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
        "HISTORIJA",
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HistoryComments()));
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
                   Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HistoryReviews()));
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
                   Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HistoryTestDrives()));
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
            SizedBox(
                width: 200,
                height: 120,
                child: Image.network(
                  "https://cdn.icon-icons.com/icons2/2468/PNG/512/user_user_profile_user_icon_user_thump_icon_149321.png",
                )),
            const SizedBox(height: 10),
            const Text(
              "User since 12 Jan, 2024",
              style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w400),
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const EditProfile()));
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
}
