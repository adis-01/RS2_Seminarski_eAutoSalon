import 'package:eautosalon_mobile/screens/about_us_screen.dart';
import 'package:eautosalon_mobile/screens/employees_screen.dart';
import 'package:eautosalon_mobile/screens/login_screen.dart';
import 'package:eautosalon_mobile/screens/news_screen.dart';
import 'package:eautosalon_mobile/screens/reviews_screen.dart';
import 'package:eautosalon_mobile/screens/user_profile_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/drawer_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.grey[900],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10))
          ),
        child: ListView(
          padding: const EdgeInsets.all(20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    splashRadius: 20,
                    onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: const Icon(Icons.close, size: 25, color: Colors.white,))
                ],
              ),
              Center(
                child: Image.asset("assets/images/car_icon.png", width: 90, height: 70,),
              ),
              const SizedBox(height: 15),
              MyDrawerListTile(
                title: 'Proizvodi', 
                icon: Icons.home, 
                onTap: (){
                  Navigator.of(context).pop();
                }
              ),
              const SizedBox(height: 10),
              MyDrawerListTile(
                title:'Uposlenici', 
                icon: Icons.business, 
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const EmployeesScreen()));
                }
              ),
              const SizedBox(height: 10),
              MyDrawerListTile(
                title:'Novosti', 
                icon: Icons.newspaper, 
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>const NewsScreen()));
                }
              ),
              const SizedBox(height: 10),
              MyDrawerListTile(
                title:'Korisnički profil', 
                icon: Icons.settings, 
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const UserProfile()));
                }
              ),
              const SizedBox(height: 10),
              MyDrawerListTile(
                title: 'Recenzije', 
                icon: Icons.star,
                 onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const ReviewsScreen()));
                 }),
              const SizedBox(height: 10),
              MyDrawerListTile(
                title:'Kontakt', 
                icon: Icons.phone, 
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const AboutScreen()));
                }
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 0.6, color: Colors.white, indent: 10, endIndent: 10,),
              const SizedBox(height: 8),
              MyDrawerListTile(
                title:'Odjava', 
                icon: Icons.logout, 
                onTap: (){
                  MyDialogs.showQuestion(context, 'Da li ste sigurni da se želite odjaviti?', () { 
                    Authorization.username = "";
                    Authorization.password = "";
                    Authorization.userId = null;
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
                  });
                }
              ),
              const SizedBox(height: 15),
            ],
          ),
        )
    );
  }
}