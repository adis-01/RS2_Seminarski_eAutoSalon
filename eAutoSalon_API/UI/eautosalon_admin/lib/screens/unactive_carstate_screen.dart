import 'package:eautosalon_admin/models/car.dart';
import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class PastCarsScreen extends StatefulWidget {
  const PastCarsScreen({super.key});

  @override
  State<PastCarsScreen> createState() => _PastCarsScreenState();
}

class _PastCarsScreenState extends State<PastCarsScreen> {
  int _currentPage = 1;
  final _pageSize = 3;
  bool isLoading = true;
  SearchResult<Automobil>? result;
  late CarProvider _carProvider;

  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Završeni oglasi',
        body: Container(
          padding: const EdgeInsets.all(25),
          child: isLoading
              ? const Center(child: CircularProgressIndicator(color: Colors.blueGrey,))
              : SingleChildScrollView(
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildBack(context),
                        ],
                      ),
                      const SizedBox(height: 10),
                      result?.count != 0
                          ? Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 5,
                              runSpacing: 10,
                              children: result?.list
                                      .map((Automobil auto) =>
                                          buildContainer(context, auto))
                                      .toList() ??
                                  [])
                          : const Center(child: Text("NO DATA")),
                      const SizedBox(height: 25),
                      (result?.total ?? 0) > 0 ? buildPagingArrows() : const Text("")
                    ],
                  ),
              ),
        ),
        floatingEnabled: false);
  }

  MaterialButton buildBack(BuildContext context) {
    return MaterialButton(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
        color: Colors.blueGrey,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back, color: Colors.white));
  }

  Container buildContainer(BuildContext context, Automobil auto) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white54,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          auto.slika != ""
              ? SizedBox(
                  width: double.infinity, child: fromBase64String(auto.slika!))
              : const SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Center(
                    child: Icon(
                      Icons.no_photography,
                      size: 40,
                      color: Colors.black,
                    ),
                  )),
          const SizedBox(height: 15),
          Text(
            "${auto.proizvodjac ?? "null"} ${auto.model ?? "null"}",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 13),
          Text(auto.godinaProizvodnje.toString(),
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w400)),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${auto.formattedPrice}",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const Text("Prodano",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }

  Row buildPagingArrows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                minimumSize: const Size(60, 45),
                disabledBackgroundColor: Colors.grey),
            onPressed: _currentPage > 1
                ? () {
                    setState(() {
                      _currentPage--;
                      isLoading = true;
                    });
                    fetchData();
                  }
                : null,
            child: const Icon(Icons.arrow_back, size: 20, color: Colors.white)),
        Text(
          "Stranica $_currentPage od ${result?.total ?? "null"}",
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                minimumSize: const Size(60, 45),
                disabledBackgroundColor: Colors.grey),
            onPressed: (result?.hasNext ?? false)
                ? () {
                    setState(() {
                      _currentPage++;
                      isLoading = true;
                    });
                    fetchData();
                  }
                : null,
            child: const Icon(
              Icons.arrow_forward,
              size: 20,
              color: Colors.white,
            ))
      ],
    );
  }

  Future<void> fetchData() async {
    try {
      var data = await _carProvider
          .getZavrsene({'page': _currentPage, 'pageSize': _pageSize});
      setState(() {
        result = data;
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
