import 'package:flutter/material.dart';

class HistoryReviewTile extends StatelessWidget {
  final int ocjena;
  final String? comment;
  const HistoryReviewTile({super.key, required this.ocjena, this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.star, color: Colors.yellow[800], size: 25,),
              const SizedBox(width: 10),
              Text(ocjena.toString(), style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),)
             ],
          ),
          const SizedBox(height: 10),
          comment != null ? 
          Text(comment.toString(), style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),)
          : const Text("NEMA KOMENTARA", textAlign: TextAlign.center, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 15),)
         ],
      ),
    );
  }
}