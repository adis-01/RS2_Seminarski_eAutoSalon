import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';

class HistoryTestDrives extends StatefulWidget {
  const HistoryTestDrives({super.key});

  @override
  State<HistoryTestDrives> createState() => _HistoryTestDrivesState();
}

class _HistoryTestDrivesState extends State<HistoryTestDrives> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Vaše vožnje',
       body: Center(
        child: Text("HISTORIJA TESTNIH VOŽNJI"),
       )
    );
  }
}