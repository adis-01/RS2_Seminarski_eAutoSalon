import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final String username;
  final int ocjena;
  final String? komentar;
  const ReviewTile({super.key,required this.username, required this.ocjena, this.komentar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.3,
                        color: Colors.black87
                      ),
                      shape: BoxShape.circle
                    ),
                    child: const Center(child: Icon(Icons.person, color: Colors.blueGrey,)),
                  ),
                  const SizedBox(width: 5),
                  Text(username.toUpperCase(), style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold),)
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[800], size: 20,),
                  const SizedBox(width: 5),
                  Text(ocjena.toString(), style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),)
                ],
              )
            ],
          ),
          const SizedBox(height: 5),
          const Divider(thickness: 0.3, color: Colors.black87, endIndent: 15, indent: 15,),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: komentar != null ?
            Text(komentar!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.blueGrey),)
            : const Center(child: Text('Korisnik nije ostavio komentar', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey,fontSize: 16),)), 
          )
        ],
      ),
    );
  }
}