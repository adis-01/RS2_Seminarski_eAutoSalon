import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class HistoryComments extends StatefulWidget {
  const HistoryComments({super.key});

  @override
  State<HistoryComments> createState() => _HistoryCommentsState();
}

class _HistoryCommentsState extends State<HistoryComments> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Vaši komentari',
       body: Center(
        child: Text("HISTORIJA KOMENTARA"),
       )
    );
  }
}