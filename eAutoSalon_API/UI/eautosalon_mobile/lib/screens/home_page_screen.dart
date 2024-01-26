import 'package:eautosalon_mobile/screens/car_details_screen.dart';
import 'package:eautosalon_mobile/screens/login_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/drawer.dart';
import 'package:eautosalon_mobile/widgets/filter_car_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../models/search_result.dart';
import '../providers/car_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SearchResult<Car>? result;
  bool isLoading = true;
  int currentPage = 1;
  final _pageSize = 4;
  late CarProvider _carProvider;
  bool clearFilters = false;
  Map<String, dynamic>? filters;

  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          actions: [
            IconButton(onPressed: (){
              MyDialogs.showQuestion(context, 'Da li ste sigurni da se želite odjaviti?', () {
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const LoginScreen()));
               });
            }, icon: const Icon(Icons.logout, size: 20, color: Colors.white,))
          ],
          centerTitle: true,
          title: const Text('PROIZVODI', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400,letterSpacing: 1.5),),),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: isLoading ? 
            const Center(child: CircularProgressIndicator(color: Colors.black87,),)
            :
            SingleChildScrollView(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                const SizedBox(height: 20),
                (result?.totalPages ?? 0) > 0
                ?
                 Column(
                  children: result?.list.map((Car automobil) => buildCarContainer(automobil)).toList() ?? [],
                )
                : const Center(child: Text("Nema proizvoda", style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w400),textAlign: TextAlign.center,)),
                const SizedBox(height: 20),
                (result?.totalPages ?? 0) > 0 ? buildPagingArrows() : const Text("")
              ],
            ),
          ),
        )
      ),
    );
  }

  Row buildHeader() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("NA STANJU", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey, fontSize: 15),),
                  !clearFilters ?
                   MaterialButton(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black87,
                    shape: const CircleBorder(),
                    onPressed: () async{
                    var result = await showDialog(
                        context: context, 
                        builder: (context) =>  const FilterCar()
                      );
                    if(result != null){
                      setState(() {
                        filters = Map.from(result);
                        currentPage = 1;
                        filters!['PageSize'] = _pageSize;
                        isLoading = true;
                      });
                      getFiltered(filters);
                    }
                  }, child: const Icon(Icons.filter_alt_outlined, color: Colors.white,))
                  :
                  MaterialButton(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black87,
                    shape: const CircleBorder(),
                    onPressed: () {
                      setState(() {
                        currentPage = 1;
                        isLoading = true;
                        clearFilters=false;
                        filters = null;
                      });
                      loadData();
                  }, child: const Icon(Icons.clear_rounded, color: Colors.white,))
                ],
              );
  }

  Row buildPagingArrows() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      color: Colors.black87,
                      disabledColor: Colors.grey[400],
                      padding: const EdgeInsets.all(5),
                      onPressed: currentPage > 1 ? (){
                        setState(() {
                          isLoading = true;
                          currentPage--;
                        });
                        filters != null ? getFiltered(filters) : loadData();
                      } : null,
                      child: const Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                  ),
                  Text("$currentPage/${result?.totalPages ?? 0}", style: const TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold, letterSpacing: 2),),
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      color: Colors.black87,
                      disabledColor: Colors.grey[400],
                      padding: const EdgeInsets.all(5),
                      onPressed: 
                      (result?.hasNext ?? false) ?
                      (){
                        setState(() {
                          isLoading=true;
                          currentPage++;
                        });
                        filters != null ? getFiltered(filters) : loadData();
                      } : null,
                      child: const Icon(Icons.arrow_forward, color: Colors.white,),
                    ),
                  ),
                ],
              );
  }

  Container buildCarContainer(Car item){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                item.proizvodjacModel ?? "null",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                height: 200,
                width: double.infinity,
                child: 
                item.slika != "" 
                ?
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: fromBase64String(item.slika!),
                )
                : const Center(child: Icon(Icons.no_photography, size: 35, color: Colors.black87,),)
              ),
              const SizedBox(height: 10),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.godinaProizvodnje.toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$${item.formattedPrice}",
                    style: const TextStyle(
                        fontSize: 15, color: Colors.black87, letterSpacing: 1, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                width: 50,
                height: 40,
                child: MaterialButton(
                  padding: const EdgeInsets.all(5),
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CarDetails(automobil: item,)));
                  },
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  
  Future<void> loadData() async{
    try {
      var data = await _carProvider.getAktivne({'PageSize' : _pageSize, 'Page' : currentPage});
      setState(() {
        result = data;
        isLoading = false;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }

  Future<void> getFiltered (dynamic params) async{
    try {
      filters!['Page'] = currentPage;
      var data = await _carProvider.getFiltered(params);
      setState(() {
        result = data;
        isLoading=false;
        clearFilters = true;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }

}