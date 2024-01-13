import 'package:eautosalon_admin/models/search_result.dart';
import 'package:eautosalon_admin/providers/user_provider.dart';
import 'package:eautosalon_admin/screens/edit_user_screen.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  SearchResult<User>? result;
  bool _disabledButton = true;
  bool isLoading = true;
  bool tableLoading = true;
  bool clearFilters = false;
  final _searchController = TextEditingController();
  late UserProvider _userProvider;
  int pageSize = 5;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      floatingEnabled: false,
        title: 'Korisnici',
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) =>
                                      const HomePageScreen()));
                            },
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                            color: const Color(0xFF248BD6),
                            child: const Icon(Icons.arrow_back,
                                color: Colors.white, size: 25),
                          ),
                          _buildSearchBar(),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Center(
                        child: tableLoading ? const CircularProgressIndicator()
                        : Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 30, bottom: 30),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 0.8, color: Colors.blueGrey)),
                          child: Column(
                            children: [
                              _buildColumnHeader(),
                              const Divider(
                                  thickness: 0.4,
                                  color: Colors.blueGrey,
                                  indent: 20,
                                  endIndent: 20),
                              const SizedBox(height: 10),
                              _buildDataTable(),
                              const SizedBox(
                                height: 20,
                              ),
                              _buildPaging(),
                              const SizedBox(height: 10)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }

  Wrap _buildPaging() {
    return Wrap(
      spacing: 15,
      runSpacing: 20,
      children: [
        ElevatedButton(
                onPressed: page > 1 ? () {
                  setState(() {
                    page--;
                    tableLoading = true;
                  });
                 try {
                    _loadData();
                  } catch (e) {
                    CustomDialogs.showError(context, e.toString());
                  }
                } : null,
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 35),
                    backgroundColor: const Color(0xFF248BD6)),
                child: const Text('Prethodna')),
            ElevatedButton(
                onPressed: result != null && result!.hasNext! ? () {
                  setState(() {
                    page++;
                    tableLoading = true;
                  });
                  try {
                    _loadData();
                  } catch (e) {
                    CustomDialogs.showError(context, e.toString());
                  }
                } : null,
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 35),
                    backgroundColor: const Color(0xFF248BD6)),
                child: const Text('Sljedeća'))
      ],
    );
  }

  Widget _buildColumnHeader() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.people,
            size: 35,
            color: Colors.blueGrey,
          ),
          Text("Stranica $page od ${result!.total ?? "null"}",
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
        decoration: const BoxDecoration(color: Colors.white30),
        border: TableBorder.all(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(5),
            width: 0.5),
        columns: const [
          DataColumn(
              label: Expanded(
                  child: Text('Username',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)))),
          DataColumn(
              label: Expanded(
                  child: Text('First name',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)))),
          DataColumn(
              label: Expanded(
                  child: Text('Last name',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)))),
          DataColumn(
              label: Expanded(
                  child: Text('Email',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)))),
          DataColumn(
              label: Expanded(
                  child: Text('Edit',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)))),
          DataColumn(
              label: Expanded(
                  child: Text('Delete',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)))),
        ],
        rows: result?.list
                .map((User user) => DataRow(cells: [
                      DataCell(Text(user.username ?? "username")),
                      DataCell(Text(user.firstName ?? "fname")),
                      DataCell(Text(user.lastName ?? "lname")),
                      DataCell(Text(user.email ?? "email")),
                      DataCell(IconButton(
                        splashRadius: 15,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => EditUser(user: user)));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.indigo[400],
                        ),
                      )),
                      DataCell(IconButton(
                        splashRadius: 15,
                        onPressed: () {
                          CustomDialogs.showQuestion(context,
                              'Izbrisati korisnika ${user.firstName} ${user.lastName}?',
                              () async {
                            try {
                              await _userProvider.delete(user.korisnikId!);
                              _loadData();
                            } catch (e) {
                              CustomDialogs.showError(context, e.toString());
                            }
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[400],
                        ),
                      ))
                    ]))
                .toList() ??
            []);
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        clearFilters
            ? Tooltip(
                message: 'Očisti filtere',
                child: IconButton(
                    splashRadius: 5,
                    onPressed: () async {
                      try {
                        setState(() {
                          page = 1;
                          _searchController.text = "";
                          clearFilters = false;
                          _disabledButton = true;
                          tableLoading=true;
                        });
                        _loadData();
                      } catch (e) {
                        CustomDialogs.showError(context, e.toString());
                      }
                    },
                    icon: const Icon(Icons.cleaning_services,
                        size: 25, color: Color(0xFF248BD6))))
            : const Text(""),
        const SizedBox(width: 5),
        SizedBox(
          width: 320,
          height: 50,
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFF248BD6),
              ),
              hintText: 'Pretraži korisnike...',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onChanged: (input) {
              setState(() {
                _disabledButton = input.isEmpty;
              });
            },
          ),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
            onPressed: _disabledButton
                ? null
                : () async {
                    try {
                      setState(() {
                        page = 1;
                        clearFilters = true;
                        tableLoading=true;
                      });
                      
                     _loadData();
                    } catch (e) {
                      CustomDialogs.showError(context, e.toString());
                    }
                  },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(50, 50),
              backgroundColor: const Color(0xFF248BD6),
            ),
            child: const Text(
              'Pretraga',
              style: TextStyle(fontSize: 15),
            ))
      ],
    );
  }

  void _loadData() async {
    try {
      dynamic params;
      if(_disabledButton){
        params = {'page' : page, 'pageSize' : pageSize};
      }
      else{
        params = {'FTS' : _searchController.text, 'page' : page, 'pageSize' : pageSize};
      }
      var data = await _userProvider.getPaged(params);
      setState(() {
        result = data;
        isLoading = false;
        tableLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
