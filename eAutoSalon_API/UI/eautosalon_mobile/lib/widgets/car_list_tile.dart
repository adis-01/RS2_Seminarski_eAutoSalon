import 'package:flutter/material.dart';

class CarTile extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String price;
  final String godinaProizvodnje;
  const CarTile(
      {super.key,
      required this.title,
      required this.price,
      required this.onTap,
      required this.godinaProizvodnje});

  @override
  Widget build(BuildContext context) {
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
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                height: 200,
                width: double.infinity,
                child: Center(
                    child: Icon(
                  Icons.no_photography,
                  color: Colors.black87,
                )),
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
                    godinaProizvodnje,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$$price",
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
                  onPressed: onTap,
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
}
