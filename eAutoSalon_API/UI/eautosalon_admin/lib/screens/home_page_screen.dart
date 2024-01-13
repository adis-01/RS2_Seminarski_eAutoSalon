import 'package:eautosalon_admin/models/car.dart';
import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/screens/car_details_screen.dart';
import 'package:eautosalon_admin/screens/new_car_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentPage = 1;
  final _pageSize = 3;
  late CarProvider _carProvider;
  SearchResult<Automobil>? result;
  bool isLoading = true;
  bool searchDisabled = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      floatingEnabled: true,
      onFloatingPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const NewCarScreen()));
      },
        title: 'Automobili',
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      result?.count != 0
                          ? Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: result?.list
                                      .map((Automobil item) =>
                                          _buildContainer(context, item))
                                      .toList() ??
                                  [],
                            )
                          : const Text("No data"),
                      const SizedBox(height: 25),
                      result?.count != 0 ? buildPagingArrows() : const Text("")
                    ],
                  ),
                ),
              ));
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
                      isLoading = true;
                      _currentPage--;
                      fetchData();
                    });
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
                      isLoading = true;
                      _currentPage++;
                      fetchData();
                    });
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

  Container _buildContainer(BuildContext context, Automobil auto) {
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
                  child: Icon(Icons.photo, size: 40, color: Colors.black)),
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
              Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(13)),
                child: Tooltip(
                  message: 'Detalji',
                  child: IconButton(
                    splashRadius: 0.1,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => CarDetails(
                                automobil: auto,
                              )));
                    },
                    icon: const Icon(Icons.more_horiz,
                        size: 23, color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      var data = await _carProvider
          .getAktivne({'Page': _currentPage, 'PageSize': _pageSize});
      setState(() {
        result = data;
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
