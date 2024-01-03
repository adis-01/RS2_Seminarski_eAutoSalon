
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Automobili', 
      body: Center(
        child: Column(
          children: [
            Text('hello ${Authorization.username}'),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            },
             child: const Text('back')
             )
          ],
        ),
      ),
      );
  }
}