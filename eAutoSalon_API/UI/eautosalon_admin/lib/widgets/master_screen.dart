import 'package:eautosalon_admin/screens/employees_screen.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/screens/users_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../utils/util.dart';

class MasterScreen extends StatefulWidget {
  String title;
  Widget body;
  MasterScreen({super.key, required this.title, required this.body});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarOpacity: 0.7,
        centerTitle: true,
        elevation: 3,
        title: Text(widget.title,
            style: const TextStyle(
                fontSize: 25, letterSpacing: 0.9, fontWeight: FontWeight.w700)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      drawer: Drawer(
        width: 400,
        backgroundColor: const Color(0xFFE0C2F2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        )),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.navigation, size: 30, color: Colors.black),
                IconButton(
                    splashRadius: 30,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close_outlined,
                      color: Colors.black,
                      size: 30,
                    ))
              ],
            ),
            const SizedBox(height: 15),
            const Text('eAutoSalon',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: Colors.black87)),
            const SizedBox(height: 15),
            const Divider(
                color: Colors.black54,
                thickness: 0.5,
                indent: 10,
                endIndent: 10),
            const SizedBox(height: 15),
            buildListTile('Automobili', Icons.directions_car, () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const HomePageScreen()));
            }),
            const SizedBox(height: 15),
            buildListTile('Korisnici', Icons.people, () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (builder)=> const UsersScreen()
              ));
            }),
            const SizedBox(height: 15),
            buildListTile('Uposlenici', Icons.business, () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const EmployeesScreen()));
            }),
            const SizedBox(height: 15),
            buildListTile('Izvještaj', Icons.report, () {}),
            const SizedBox(height: 15),
            buildListTile('Odjava', Icons.logout, () {
              CustomDialogs.showQuestion(
                  context, 'Da li ste sigurni da se želite odjaviti?', () {
                _logOut();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => const LoginScreen()));
              });
            }),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  color: Colors.black87,
                  width: 200,
                  height: 180,
                )
              ],
            )
          ],
        ),
      ),
      body: widget.body,
    );
  }

  ListTile buildListTile(String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 22),
      leading:
          Icon(icon, size: 35, color: Colors.deepPurple //Color(0xFF7D5BA6),
              ),
      title: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 19,
            color: Color(0xFF36454F),
            letterSpacing: 0.5),
      ),
      onTap: onTap,
    );
  }

  void _logOut() {
    Authorization.username = "";
    Authorization.password = "";
  }
}
