import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';

import 'home_page_screen.dart';

class TestDrivesScreen extends StatefulWidget {
  const TestDrivesScreen({super.key});

  @override
  State<TestDrivesScreen> createState() => _TestDrivesScreenState();
}

class _TestDrivesScreenState extends State<TestDrivesScreen> {
  //bool _activeTests = true;
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Testne vožnje',
        body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
              _buildBack(context),
              const SizedBox(height: 45),
            ]
            )
            )
            );
  }

  Row _buildBack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          shape: const CircleBorder(),
          color: const Color(0xFF248BD6),
          padding: const EdgeInsets.all(15),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => const HomePageScreen()));
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
