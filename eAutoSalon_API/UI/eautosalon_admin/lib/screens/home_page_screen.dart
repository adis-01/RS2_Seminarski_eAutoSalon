
import 'package:eautosalon_admin/screens/car_details_screen.dart';
import 'package:eautosalon_admin/screens/new_car_screen.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Automobili', 
      body: 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              buildNew(context),
              const SizedBox(height: 5),
              Wrap(
                spacing: 15,
                runSpacing: 10,
                children: [
                  Container(
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
                          Image.network("https://img.freepik.com/free-psd/white-car-isolated_176382-1488.jpg?w=1060&t=st=1704911316~exp=1704911916~hmac=fb4b166588486ffbd0b0f3804e8374a0e4ae2eff11a202e48e80f89c7a75825a"),
                          const SizedBox(height: 15),
                          const Text("Proizvođač Model", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                          const SizedBox(height: 13),
                          const Text("2016", style: TextStyle(fontSize: 18,color: Colors.blueGrey, fontWeight: FontWeight.w400)),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                             const Text("\$123.99", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),),
                             Container(
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(13)
                              ),
                              child: Tooltip(
                                message: 'Detalji',
                                child: IconButton(
                                  splashRadius: 0.1,
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const CarDetails()));
                                  },
                                  icon: const Icon(Icons.more_horiz, size: 23, color: Colors.white),
                                ),
                              ),
                             )
                            ],
                          )
                        ],
                      ),
                  )
                ],
              )
            ],
          ),
        ),
      )
      );
  }
  
  Widget buildNew(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Tooltip(
          message: 'Novi automobil',
          child: MaterialButton(
            padding: const EdgeInsets.all(15),
            shape: const CircleBorder(),
            color: const Color(0xFF248BD6),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const NewCarScreen()));
            },
          child: const Icon(Icons.add, size: 25, color: Colors.white,),
          ),
        ),
      ],
    );
  }
}