
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/user.dart';

class EditUser extends StatefulWidget {
  User user;
  EditUser({super.key, required this.user});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Detalji korisnika ${this.widget.user.firstName} ${this.widget.user.lastName}", 
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back))
            ],
          ),
          Center(
            child: Text('User ${widget.user.username}'),
          )
        ],
      )
      );
  }
}