
import 'package:eautosalon_admin/screens/employees_screen.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/screens/test_drives_screen.dart';
import 'package:eautosalon_admin/screens/user_profile_screen.dart';
import 'package:eautosalon_admin/screens/users_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../utils/util.dart';

class MasterScreen extends StatefulWidget {
  String title;
  Widget body;
  bool floatingEnabled;
  VoidCallback? onFloatingPressed;
  MasterScreen({super.key, required this.title, required this.body, required this.floatingEnabled, this.onFloatingPressed});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: widget.floatingEnabled ? 
      FloatingActionButton(
        tooltip: 'Dodaj',
        backgroundColor: Colors.blueGrey,
        onPressed: widget.onFloatingPressed,
        child: const Icon(Icons.add, size: 25, color: Colors.white,),
      ) : null, 
      appBar: AppBar(
        actions: [
          Tooltip(
            message: 'Početna stranica',
            child: IconButton(
              hoverColor: Colors.black26,
              padding: const EdgeInsets.all(15),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const HomePageScreen()));
              }, 
              icon: const Icon(Icons.home, color: Colors.white, size: 25)),
          ),
          const SizedBox(width: 25),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Tooltip(
              message: 'Odjavi se',
              child: IconButton(
                hoverColor: Colors.black26,
                onPressed: (){
                  CustomDialogs.showQuestion(context, 'Da li ste sigurni da se želite odjaviti?', () { 
                    _logOut();
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
                  });
                },
                icon: const Icon(Icons.logout, color: Colors.white, size: 25),
              ),
            ),
          )
        ],
        backgroundColor: Colors.black87,
        centerTitle: true,
        elevation: 3,
        title: Text(widget.title.toUpperCase(),
            style: const TextStyle(
                fontSize: 22, letterSpacing: 3.5, fontWeight: FontWeight.w700, color: Colors.white70)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      drawer: Drawer(
        width: 400,
        backgroundColor: Colors.grey[900],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        )),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("eAutoSalon", style: TextStyle(fontSize: 15, color: Colors.white, letterSpacing: 2.5)),
                IconButton(
                    splashRadius: 20,
                    hoverColor: Colors.black45,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close_outlined,
                      color: Colors.white,
                      size: 25,
                    ))
              ],
            ),
            const SizedBox(height: 15),
            const Center(
              child: Icon(
                Icons.directions_car_outlined, size: 45, color: Colors.white,
              ),
            ),
            const SizedBox(height: 45),
            buildListTile('Automobili', Icons.directions_car, () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const HomePageScreen()));
            }),
            const SizedBox(height: 15),
            buildListTile('Korisnici', Icons.people, () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => const UsersScreen()));
            }),
            const SizedBox(height: 15),
            buildListTile('Uposlenici', Icons.business, () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const EmployeesScreen()));
            }),
            const SizedBox(height: 15),
              buildListTile('Korisnički profil', Icons.settings, () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => const UserProfileScreen())
              );
             }),
            const SizedBox(height: 15),
            ListTile(
              hoverColor: Colors.black45,
              contentPadding: const EdgeInsets.only(left: 20),
              leading: Image.asset("assets/images/steering_wheel.png",
                  width: 25, color: Colors.white),
              title: const Text(
                'TESTNE VOŽNJE',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    letterSpacing: 2.5),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => const TestDrivesScreen())
                );
              },
            ),
            const SizedBox(height: 15),
            buildListTile('Izvještaj', Icons.report, () {}),
            const SizedBox(height: 20),
            const Divider(
                color: Colors.white,
                thickness: 0.6,
                indent: 15,
                endIndent: 15),
            const SizedBox(height: 20),
            buildListTile('Odjava', Icons.logout, () {
              CustomDialogs.showQuestion(
                  context, 'Da li ste sigurni da se želite odjaviti?', () {
                _logOut();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => const LoginScreen()));
              });
            }),
          ],
        ),
      ),
      body: widget.body,
    );
  }

  ListTile buildListTile(String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      hoverColor: Colors.black45,
      contentPadding: const EdgeInsets.only(left: 20),
      leading: Icon(icon,
          size: 25, color: Colors.white,
          ),
      title: Text(
        text.toUpperCase(),
        style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
            letterSpacing: 2.5),
      ),
      onTap: onTap,
    );
  }

  void _logOut() {
    Authorization.username = "";
    Authorization.password = "";
  }
}
