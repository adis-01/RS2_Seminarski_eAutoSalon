import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

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
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "PROIZVOĐAČ MODEL",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                          letterSpacing: 1.5),
                    ),
                  ],
                ),
                buildCreditCardExample(),
                const Text(
                  "Unesite podatke o kartici",
                  style: TextStyle(
                      color: Colors.black87,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 0.2
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: TextField(
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: 'CVC',
                            hintStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black54)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white))
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: TextField(
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: 'VALID THRU',
                            hintStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black54)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.white))
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.black87,
                                Colors.grey
                              ]
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          padding: const EdgeInsets.all(15),
                          child: const Text("IZVRŠI TRANSAKCIJU", 
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 1.5),),
                        ),
                      )
              ],
            ),
          ),
        ));
  }

  Container buildCreditCardExample() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
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
          const Text("VALID THRU", style: TextStyle(color: Colors.white70, fontSize: 11),),
          const SizedBox(height: 2),
          const Text("12/24", style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontSize: 12),),
          const SizedBox(height: 5),
          const Text("IME PREZIME", style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: 2, fontWeight: FontWeight.w400),)
        ],
      ),
    );
  }
}
