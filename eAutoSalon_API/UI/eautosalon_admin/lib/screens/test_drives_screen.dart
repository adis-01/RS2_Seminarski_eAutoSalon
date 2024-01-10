// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/models/search_result.dart';
import 'package:eautosalon_admin/models/test_drives.dart';
import 'package:eautosalon_admin/providers/test_drive_provider.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page_screen.dart';

class TestDrivesScreen extends StatefulWidget {
  const TestDrivesScreen({super.key});

  @override
  State<TestDrivesScreen> createState() => _TestDrivesScreenState();
}

class _TestDrivesScreenState extends State<TestDrivesScreen> {
  SearchResult<TestDrives>? activeResult;
  SearchResult<TestDrives>? finishedResult;
  bool _activeTests = true;
  bool isLoading = true;
  bool tableLoading = false;
  int page = 1;
  int pageSize = 5;
  late TestDriveProvider _testProvider;

  @override
  void initState() {
    super.initState();
    _testProvider = context.read<TestDriveProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Testne vožnje',
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(children: [
                    _buildBack(context),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 25,
                      runSpacing: 5,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _activeTests = true;
                              page = 1;
                              tableLoading = true;
                              fetchData();
                            });
                          },
                          child: Text(
                            "Aktivne",
                            style: TextStyle(
                                fontSize: 20,
                                color: _activeTests
                                    ? const Color(0xFF248BD6)
                                    : Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _activeTests = false;
                              page = 1;
                              tableLoading = true;
                              fetchData();
                            });
                          },
                          child: Text(
                            "Završene",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _activeTests
                                    ? Colors.blueGrey
                                    : const Color(0xFF248BD6)),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                        thickness: 0.2,
                        color: Colors.blueGrey,
                        indent: 500,
                        endIndent: 500,
                        height: 40),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.8, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/steering_wheel.png",
                                  color: Colors.blueGrey,
                                  width: 35,
                                  height: 35),
                              _activeTests
                                  ? Text(
                                      "Stranica $page od ${activeResult?.total ?? "null"}",
                                      style: const TextStyle(fontSize: 16, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                                      )
                                  : Text(
                                      "Stranica $page od ${finishedResult?.total ?? "null"}"),
                            ],
                          ),
                          const SizedBox(height: 25),
                          tableLoading
                              ? const Center(child: CircularProgressIndicator())
                              : _activeTests
                                  ? _buildActive()
                                  : _buildFinished(),
                          const SizedBox(height: 25),
                          Wrap(
                            spacing: 15,
                            runSpacing: 20,
                            children: [
                              ElevatedButton(
                                  onPressed: page > 1
                                      ? () {
                                          setState(() {
                                            page--;
                                            tableLoading = true;
                                          });
                                          fetchData();
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(100, 35),
                                      backgroundColor: const Color(0xFF248BD6)),
                                  child: const Text('Previous')),
                              ElevatedButton(
                                  onPressed: 
                                        (activeResult?.hasNext ?? false) || (finishedResult?.hasNext ?? false)
                                      ? () {
                                        setState(() {
                                          page++;
                                          tableLoading=true;
                                        });
                                        fetchData();
                                      }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(100, 35),
                                      backgroundColor: const Color(0xFF248BD6)),
                                  child: const Text('Next'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
                )));
  }

  DataTable _buildActive() {
    return DataTable(
        decoration: const BoxDecoration(color: Colors.white30),
        border: TableBorder.all(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(5),
            width: 0.5),
        columns: const [
          DataColumn(label: Icon(Icons.date_range)),
          DataColumn(label: Icon(Icons.access_time_filled)),
          DataColumn(label: Icon(Icons.directions_car)),
          DataColumn(
            label: Icon(Icons.person),
          ),
          DataColumn(label: Icon(Icons.work)),
          DataColumn(label: Text('Otkaži')),
          DataColumn(label: Text('Završi'))
        ],
        rows: activeResult?.list
                .map((TestDrives test) => DataRow(cells: [
                      DataCell(Text(test.date)),
                      DataCell(Text(test.time)),
                      DataCell(Text(test.car)),
                      DataCell(Text(test.vozac)),
                      DataCell(Text(test.uposleni)),
                      DataCell(IconButton(
                        splashRadius: 15,
                        onPressed: () async {
                          try {
                            await _testProvider.cancel(test.testnaVoznjaId!);
                            CustomDialogs.showSuccess(
                                context, 'Uspješno otkazana vožnja', () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) =>
                                      const TestDrivesScreen()));
                            });
                          } catch (e) {
                            CustomDialogs.showError(context, e.toString());
                          }
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red[400],
                        ),
                      )),
                      DataCell(IconButton(
                        splashRadius: 15,
                        onPressed: () async {
                          try {
                            await _testProvider.complete(test.testnaVoznjaId!);
                            CustomDialogs.showSuccess(
                                context, 'Testna vožnja završena', () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) =>
                                      const TestDrivesScreen()));
                            });
                          } catch (e) {
                            CustomDialogs.showError(context, e.toString());
                          }
                        },
                        icon: Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green[400],
                        ),
                      ))
                    ]))
                .toList() ??
            []);
  }

  DataTable _buildFinished() {
    return DataTable(
        decoration: const BoxDecoration(color: Colors.white30),
        border: TableBorder.all(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(5),
            width: 0.5),
        columns: const [
          DataColumn(label: Icon(Icons.date_range)),
          DataColumn(label: Icon(Icons.access_time_filled)),
          DataColumn(label: Icon(Icons.directions_car)),
          DataColumn(
            label: Icon(Icons.person),
          ),
          DataColumn(label: Icon(Icons.work)),
          DataColumn(label: Text('Status'))
        ],
        rows: finishedResult?.list
                .map((TestDrives test) => DataRow(cells: [
                      DataCell(Text(test.date)),
                      DataCell(Text(test.time)),
                      DataCell(Text(test.car)),
                      DataCell(Text(test.vozac)),
                      DataCell(Text(test.uposleni)),
                      DataCell(Text(test.status ?? "status"))
                    ]))
                .toList() ??
            []);
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

  Future<void> fetchData() async {
    try {
      if (_activeTests) {
        var data =
            await _testProvider.getActive({'pageSize': pageSize, 'page': page});
        setState(() {
          activeResult = data;
          isLoading = false;
          tableLoading = false;
        });
      } else {
        var data = await _testProvider.getFinished({
          'pageSize': 5,
          'page': page,
        });
        setState(() {
          finishedResult = data;
          tableLoading = false;
        });
      }
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
