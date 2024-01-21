import 'package:eautosalon_mobile/screens/car_details_screen.dart';
import 'package:eautosalon_mobile/screens/login_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/widgets/car_list_tile.dart';
import 'package:eautosalon_mobile/widgets/drawer.dart';
import 'package:eautosalon_mobile/widgets/filter_car_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                const SizedBox(height: 20),
                CarTile(title: 'Audi A7', price: '10,550.00', godinaProizvodnje: '2010' ,onTap: (){}),
                CarTile(title: 'BMW i8', price: '25,442.00', onTap: (){}, godinaProizvodnje: '2014'),
                CarTile(title: 'Renault Megane i8', price: '8,442.00', onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const CarDetails()));
                }, godinaProizvodnje: '2016'),
                const SizedBox(height: 10),
                buildPagingArrows()
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
                  MaterialButton(
                    padding: const EdgeInsets.all(5),
                    color: Colors.black87,
                    shape: const CircleBorder(),
                    onPressed: (){
                      showDialog(
                        context: context, 
                        builder: (context) =>  const FilterCar()
                      );
                  }, child: const Icon(Icons.filter_alt_outlined, color: Colors.white,))
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
                      onPressed: (){

                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                  ),
                  const Text("1/1", style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold, letterSpacing: 2),),
                  SizedBox(
                    width: 60,
                    height: 40,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      color: Colors.black87,
                      disabledColor: Colors.grey[400],
                      padding: const EdgeInsets.all(5),
                      onPressed: (){

                      },
                      child: const Icon(Icons.arrow_forward, color: Colors.white,),
                    ),
                  ),
                ],
              );
  }
}