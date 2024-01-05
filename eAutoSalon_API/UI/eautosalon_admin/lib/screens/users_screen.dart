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
  bool clearFilters = false;
  final _searchController = TextEditingController();
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Korisnici',
        body: isLoading ? 
        const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => const HomePageScreen()));
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
              Expanded(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:const Color.fromARGB(255, 205, 197, 209),
                      ),
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
                        ],
                      ),
                    ),
                  ),
              ),
            ],
          ),
        )
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
          RichText(
            text: const TextSpan(children: [
               TextSpan(
                text: 'Stranica ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey
                )
                ),
                TextSpan(
                  text: "1 ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700
                  )
                ),
                TextSpan(
                  text: 'od ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey
                  )
                ),
                TextSpan(
                  text: '2',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700
                  )
                )
            ]
            )
            ),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: 'Ukupan broj korisnika: ',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey)),
            TextSpan(
                text: result?.count.toString() ?? "0",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700))
          ]))
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
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
                      child: Text('Profile picture',
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
            rows:  
            result?.list.map((User user) => 
            DataRow(cells:[
              DataCell(Text(user.username ?? "username")),
              DataCell(Text(user.firstName ?? "fname")),
              DataCell(Text(user.lastName ?? "lname")),
              const DataCell(Icon(Icons.person, size: 30)),
              DataCell(
                IconButton(
                  splashRadius: 15,
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (builder) => EditUser(user: user))
                    );
                  },
                  icon: const Icon(Icons.edit),
                )
              ),
              DataCell(
                IconButton(
                  splashRadius: 15,
                  onPressed: (){
                    CustomDialogs.showQuestion(context, 
                    'Izbrisati korisnika ${user.firstName} ${user.lastName}?',
                     () async{ 
                      try {
                        await _userProvider.delete(user.korisnikId!);
                        _loadData();
                      } catch (e) {
                        CustomDialogs.showError(context, e.toString());
                      }
                     });
                  },
                  icon: const Icon(Icons.delete),
                )
              )
            ]
            )).toList()
             ?? []
             ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

            clearFilters ? Tooltip(
          message: 'Očisti filtere',
          child: IconButton(
            splashRadius: 5,
            onPressed: () async{
            try {
              _loadData();
              setState(() {
                _searchController.text="";
                clearFilters=false;
                _disabledButton=true;
              });
            } catch (e) {
              CustomDialogs.showError(context, e.toString());
            }
          }, icon: const Icon(Icons.cleaning_services, size: 25, color: Color(0xFF248BD6)))
        ) : const Text(""),
        const SizedBox(width: 5),
        SizedBox(
          width: 320,
          height: 50,
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color:  Color(0xFF248BD6),
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
                      var list = await _userProvider
                          .getAll(filters: {'FTS': _searchController.text});

                        setState(() {
                          result = list;
                          clearFilters = true;
                        });

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
      var data = await _userProvider.getAll();
    setState(() {
      result=data;
      isLoading=false;
    });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
