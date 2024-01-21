
import 'package:flutter/material.dart';

class MyDrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const MyDrawerListTile({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10),
      leading: Icon(icon, size: 25, color: Colors.white,),
      title: Text(title.toUpperCase(), style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.5),),
      onTap: onTap,
    );
  }
}