import 'package:eautosalon_mobile/widgets/user_history_testdrives.dart';
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
       body: SingleChildScrollView(
         child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [
              HistoryTestDriveTile(car: 'BMW i8', date: '08-01-2024', uposlenik: 'Savino Stratton', status:'Završeno'),
              HistoryTestDriveTile(car: 'BMW i8', date: '08-01-2024', uposlenik: 'Savino Stratton', status: 'Otkazano',),
              HistoryTestDriveTile(car: 'BMW i8', date: '08-01-2024', uposlenik: 'Savino Stratton',status: 'Završeno',),
              HistoryTestDriveTile(car: 'BMW i8', date: '08-01-2024', uposlenik: 'Savino Stratton',status: 'Završeno',),
              HistoryTestDriveTile(car: 'BMW i8', date: '08-01-2024', uposlenik: 'Savino Stratton', status: 'Završeno',),
            ],
          ),
         ),
       )
    );
  }
}