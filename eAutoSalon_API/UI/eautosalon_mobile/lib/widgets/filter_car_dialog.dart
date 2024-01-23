import 'package:flutter/material.dart';

class FilterCar extends StatefulWidget {
  const FilterCar({super.key});

  @override
  State<FilterCar> createState() => _FilterCarState();
}

class _FilterCarState extends State<FilterCar> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  splashRadius: 20,
                  onPressed: (){
                  Navigator.of(context).pop();
                }, icon: const Icon(Icons.close, color: Colors.black87, size: 25,))
              ],
            ),
            const Text("Pređeni kilometri < od",style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
            ),
            const Text("Godina proizvodnje < od",style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w400),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black87
                ),
                child: const Text("PRETRAGA",
                  textAlign: TextAlign.center,
                 style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: 1, fontWeight: FontWeight.w400),),
              ),
            )
          ],
        ),
      ),
    );
  }
}