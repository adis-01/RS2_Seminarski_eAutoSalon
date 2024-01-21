import 'package:eautosalon_mobile/screens/history_user_comments.dart';
import 'package:eautosalon_mobile/screens/history_user_reviews.dart';
import 'package:eautosalon_mobile/screens/history_user_testdrives.dart';
import 'package:eautosalon_mobile/widgets/edit_profile_dialog.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.settings,
                      color: Colors.black87,
                      size: 20,
                    )
                  ],
                ),
                buildImage(),
                const SizedBox(height: 10),
                const Text(
                  "User since Dec, 2023",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "INFORMACIJE",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    editButton()
                  ],
                ),
                buildEmail(),
                buildFullName(),
                buildUsername(),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "HISTORIJA",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                buildComment(),
                buildTestDrives(),
                buildReviews(),
                const SizedBox(height: 20),
                buildPasswordPhoto(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }

  Row buildPasswordPhoto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text("PROMJENA SLIKE",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            MaterialButton(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              color: Colors.black54,
              onPressed: () {},
              child: const Icon(
                Icons.photo_camera_back,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Text("PROMJENA LOZINKE",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
              color: Colors.black54,
              onPressed: () {},
              child: const Icon(
                Icons.password,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }

  Container buildReviews() {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            color: Colors.grey[800]),
        child: ListTile(
          leading: const Icon(
            Icons.star,
            color: Colors.white70,
          ),
          title: const Text(
            "RECENZIJE",
            style:
                TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const HistoryReviews()));
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ));
  }

  Container buildTestDrives() {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.grey[800]),
        child: ListTile(
          leading: const Icon(
            Icons.directions_car,
            color: Colors.white70,
          ),
          title: const Text(
            "TESTNE VOŽNJE",
            style:
                TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const HistoryTestDrives()));
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ));
  }

  Container buildComment() {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Colors.grey[800]),
        child: ListTile(
          leading: const Icon(
            Icons.comment,
            color: Colors.white70,
          ),
          title: const Text(
            "KOMENTARI",
            style:
                TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const HistoryComments()));
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ));
  }

  IconButton editButton() {
    return IconButton(
        splashRadius: 25,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const EditProfile());
        },
        icon: const Icon(Icons.edit, color: Colors.black87, size: 25));
  }

  Center buildImage() {
    return Center(
      child: Container(
        width: 80,
        height: 150,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(Icons.no_photography),
        ),
      ),
    );
  }

  Container buildUsername() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          color: Colors.grey[800]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_circle,
                color: Colors.white70,
              ),
              const SizedBox(width: 5),
              const Text(
                "Username",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              )
            ],
          ),
          const Text(
            "savin0",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
          )
        ],
      ),
    );
  }

  Container buildFullName() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(color: Colors.grey[800]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.white70,
              ),
              const SizedBox(width: 5),
              const Text(
                "Ime i prezime",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              )
            ],
          ),
          const Text(
            "Adis Šipković",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
          )
        ],
      ),
    );
  }

  Container buildEmail() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Colors.grey[800]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.mail,
                color: Colors.white70,
              ),
              const SizedBox(width: 5),
              const Text(
                "Email",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              )
            ],
          ),
          const Text(
            "adis.sipkovic@edu.fit.ba",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
          )
        ],
      ),
    );
  }
}
