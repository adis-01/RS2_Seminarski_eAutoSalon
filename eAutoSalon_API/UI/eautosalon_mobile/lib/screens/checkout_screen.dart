import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

import '../models/car.dart';

class CheckoutPage extends StatefulWidget {
  final Car car;
  const CheckoutPage({super.key, required this.car});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Checkout',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCreditCardExample(),
                buildCarTile(),
                buildPriceTile(),
                buildButton()
              ],
            ),
          ),
        ));
  }

  Container buildCarTile() {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[900]
                ),
                child: ListTile(
                  title: Text(widget.car.proizvodjac ?? "null", style: const TextStyle(color: Colors.white,letterSpacing: 1.5, fontSize: 18),),
                  subtitle: Text(widget.car.model ?? "null", style: const TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 17),),
                  trailing: Image.asset("assets/images/car_icon.png", height: 70, width: 55,),
                ),
              );
  }

  Container buildPriceTile() {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[900]
                ),
                child: ListTile(
                  title: Text('\$${widget.car.formattedPrice}', style: const TextStyle(color: Colors.white,letterSpacing: 1, fontSize: 18),),
                  trailing: Image.asset("assets/images/price-tag.png", height: 45, width: 50,),
                ),
              );
  }

  GestureDetector buildButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black87, Colors.grey]),
        ),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        padding: const EdgeInsets.all(15),
        child: const Text(
          "IZVRŠI TRANSAKCIJU",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 17,
              letterSpacing: 1),
        ),
      ),
    );
  }

  Container buildCreditCardExample() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 5),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black87, Colors.grey])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(
                Icons.shopping_bag,
                size: 25,
                color: Colors.white,
              )
            ],
          ),
          Image.asset(
            "assets/images/credit_card_chip.png",
            width: 30,
            height: 30,
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "XXXX XXXX XXXX XXXX",
              style: TextStyle(
                  color: Colors.white,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "VALID THRU",
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 2),
          const Text(
            "12/24",
            style: TextStyle(
                color: Colors.white, letterSpacing: 1.5, fontSize: 12),
          ),
          const SizedBox(height: 5),
          const Text(
            "IME PREZIME",
            style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                letterSpacing: 2,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
