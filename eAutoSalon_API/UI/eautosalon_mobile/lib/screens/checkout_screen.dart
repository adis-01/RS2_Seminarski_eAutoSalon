import 'dart:convert';

import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/car.dart';

class CheckoutPage extends StatefulWidget {
  final Car car;
  const CheckoutPage({super.key, required this.car});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Map<String, dynamic>? paymentIntent;

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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black87,
                      width: 0.4
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.info_rounded, color: Colors.black54, size: 17,),
                      SizedBox(height: 5),
                      Text("Nakon što pritisnete dugme, popunite neophodna polja i potvrdite transakciju",
                      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0.5),)
                    ],
                  ),
                ),
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
      margin: const EdgeInsets.only(top: 15, right: 5, left: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
          ), color: Colors.grey[900]),
      child: ListTile(
        title: Text(
          widget.car.proizvodjac ?? "null",
          style: const TextStyle(
              color: Colors.white, letterSpacing: 1.5, fontSize: 18),
        ),
        subtitle: Text(
          widget.car.model ?? "null",
          style: const TextStyle(
              color: Colors.white, letterSpacing: 1, fontSize: 17),
        ),
        trailing: Image.asset(
          "assets/images/car_icon.png",
          height: 70,
          width: 55,
        ),
      ),
    );
  }

  Container buildPriceTile() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 3, right: 5, left: 5, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15)
          ), color: Colors.grey[900]),
      child: ListTile(
        title: Text(
          '\$${widget.car.formattedPrice}',
          style: const TextStyle(
              color: Colors.white, letterSpacing: 1, fontSize: 18),
        ),
        trailing: Image.asset(
          "assets/images/price-tag.png",
          height: 45,
          width: 50,
        ),
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
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
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
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
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

  // Future<Map<String, dynamic>> makePaymentIntent() async {
  //   final body = {
  //     'amount': widget.car.cijena.toString(),
  //     'currency': 'USD',
  //     'payment_method_types[]': 'card',
  //   };

  //   final headers = {
  //     'Authorization': 'Bearer $secKey',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //   };

  //   final response = await http.post(
  //     Uri.parse("https://api.stripe.com/v1/payment_intents"),
  //     headers: headers,
  //     body: body,
  //   );

  //   return jsonDecode(response.body);
  // }

  // Future<void> displayPaymentSheet() async {
  //   await Stripe.instance.presentPaymentSheet();
  // }

  // Future<void> makePayment() async {
  //   try {
  //     final paymentIntent = await makePaymentIntent();
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         merchantDisplayName: 'Automobil prodaja',
  //         paymentIntentClientSecret: paymentIntent['client_secret'],
  //         style: ThemeMode.dark,
  //       ),
  //     );
  //     await displayPaymentSheet();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  

}
