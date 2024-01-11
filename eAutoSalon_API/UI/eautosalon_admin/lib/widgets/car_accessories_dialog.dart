import 'package:flutter/material.dart';

class CarAcc extends StatefulWidget {
  const CarAcc({super.key});

  @override
  State<CarAcc> createState() => _CarAccState();
}

class _CarAccState extends State<CarAcc> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 800,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[300]),
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dodatna oprema",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey)),
                  IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 25,
                        color: Color(0xFF248BD6),
                      ))
                ],
              ),
              const Divider(
                  thickness: 0.3,
                  color: Colors.blueGrey,
                  indent: 10,
                  endIndent: 10,
                  height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: [
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("ABS", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_outlined, size: 15, color: Colors.green[300],),
                        )
                      ),
                    )
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Centralno zaključavanje", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_outlined, size: 15, color: Colors.green[300],),
                        )
                      ),
                    )
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Alarm", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_outlined, size: 15, color: Colors.green[300],),
                        )
                      ),
                    )
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Tempomat", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_outlined, size: 15, color: Colors.green[300],),
                        )
                      ),
                    )
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("ESP", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_outlined, size: 15, color: Colors.green[300],),
                        )
                      ),
                    )
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Servo", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_outlined, size: 15, color: Colors.green[300],),
                        )
                      ),
                    )
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Tempomat", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_outlined, size: 15, color: Colors.green[300],),
                        )
                      ),
                    )
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Parking kamera", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_outlined, size: 15, color: Colors.green[300],),
                        )
                      ),
                    )
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Električni podizači", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.check_circle_rounded, size: 16, color: Colors.green[300],),
                        )
                      ),
                    )
                  )
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF248BD6),
                      fixedSize: const Size(80, 40)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Nazad",
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
