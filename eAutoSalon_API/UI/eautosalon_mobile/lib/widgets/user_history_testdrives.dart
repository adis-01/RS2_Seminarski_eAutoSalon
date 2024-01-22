
import 'package:flutter/material.dart';

class HistoryTestDriveTile extends StatelessWidget {
  final String car;
  final String date;
  final String uposlenik;
  final String status;
  const HistoryTestDriveTile({super.key, required this.car, required this.date, required this.uposlenik, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.date_range, color: Colors.black87, size: 20,),
              Text(date, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, letterSpacing: 1, fontSize: 15),)
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.cases_rounded, color: Colors.black87, size: 20,),
              Text(uposlenik, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, letterSpacing: 1, fontSize: 15),)
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               const Icon(Icons.directions_car, color: Colors.black87, size: 20,),
              Text(car, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, letterSpacing: 1, fontSize: 15),)
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               const Icon(Icons.question_mark, color: Colors.black87, size: 20,),
              Text(status, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, letterSpacing: 1, fontSize: 15),)
            ],
          ),
        ],
      )
    );
  }
}