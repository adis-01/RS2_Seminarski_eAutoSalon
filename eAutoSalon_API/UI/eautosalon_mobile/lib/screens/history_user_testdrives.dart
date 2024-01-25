import 'package:eautosalon_mobile/models/test_drive.dart';
import 'package:eautosalon_mobile/providers/test_drive_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/master_screen.dart';

class HistoryTestDrives extends StatefulWidget {
  final int korisnikId;
  const HistoryTestDrives({super.key, required this.korisnikId});

  @override
  State<HistoryTestDrives> createState() => _HistoryTestDrivesState();
}

class _HistoryTestDrivesState extends State<HistoryTestDrives> {
  bool isLoading = true;
  late TestDriveProvider _testDriveProvider;
  late List<TestDrives> _list = [];

  @override
  void initState() {
    super.initState();
    _testDriveProvider = context.read<TestDriveProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Vaše vožnje',
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black87,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: _list.isNotEmpty
                        ? Column(
                            children: _list
                                .map((TestDrives obj) => buildTestDriveBox(obj))
                                .toList())
                        : noDataContainer()),
              ));
  }

  Center noDataContainer() {
    return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/car_icon.png",
                                width: 100,
                                height: 90,
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Do sada niste imali testnih vožnji.",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,

                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
  }

  Container buildTestDriveBox(TestDrives object) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.date_range,
                  color: Colors.black87,
                  size: 20,
                ),
                Text(
                  object.date,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 15),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.cases_rounded,
                  color: Colors.black87,
                  size: 20,
                ),
                Text(
                  object.uposleni,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 15),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.directions_car,
                  color: Colors.black87,
                  size: 20,
                ),
                Text(
                  object.car,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 15),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.question_mark,
                  color: Colors.black87,
                  size: 20,
                ),
                Text(
                  object.status ?? "Status nepoznat",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 15),
                )
              ],
            ),
          ],
        ));
  }

  Future<void> fetchData() async {
    try {
      var data = await _testDriveProvider.getHistory(widget.korisnikId);
      setState(() {
        _list = data;
        isLoading = false;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
