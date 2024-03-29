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
        floatingEnabled: false,
        title: 'Testne vožnje',
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.blueGrey,))
            : Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBack(context),
                        buildGestures(),
                        const Icon(Icons.directions_car, size: 35, color: Colors.blueGrey)
                      ],
                    ),
                    const SizedBox(height: 45),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.8, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(15)),
                      child: 
                      tableLoading ? 
                      const Center(child: CircularProgressIndicator(),)
                      :
                      Column(
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
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "Stranica $page od ${finishedResult?.total ?? "null"}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey,
                                          fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 25),
                          _activeTests
                                  ? _buildActive()
                                  : _buildFinished(),
                          const SizedBox(height: 25),
                          Wrap(
                            spacing: 15,
                            runSpacing: 20,
                            children: [
                              buildPrevious(),
                              buildNext(),
                            ],
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ]),
                )));
  }

  Container buildGestures() {
    return Container(
                        width: 250,
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  ? Colors.black87
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
                                  : Colors.black87),
                        ),
                      )
                          ],
                        ),
                      );
  }

  ElevatedButton buildNext(){
    bool hasNext;
    if(_activeTests){
      hasNext = activeResult?.hasNext ?? false;
    }
    else{
      hasNext = finishedResult?.hasNext ?? false;
    }
    return ElevatedButton(
      onPressed: 
      hasNext ?
      (){
        setState(() {
          page++;
          tableLoading=true;
        });
        fetchData();
      } : null, 
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(100,35),
      backgroundColor: Colors.blueGrey
    ),
    child: const Text('Sljedeća'));
  }

  ElevatedButton buildPrevious() {
    return ElevatedButton(
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
            backgroundColor: Colors.blueGrey),
        child: const Text('Prethodna'));
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
          color: Colors.blueGrey,
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
