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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}