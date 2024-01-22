import 'package:flutter/material.dart';

class PassChange extends StatefulWidget {
  const PassChange({super.key});

  @override
  State<PassChange> createState() => _PassChangeState();
}

class _PassChangeState extends State<PassChange> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
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
                }, icon: const Icon(Icons.close, size: 25, color: Colors.black87,))
              ],
            ),
            const SizedBox(height: 10,),
           Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]
              ),
              width: double.infinity,
              child: const TextField(
                cursorColor: Colors.blueGrey,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Trenutna lozinka',
                  hintStyle: TextStyle(color: Colors.blueGrey)
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]
              ),
              width: double.infinity,
              child: const TextField(
                cursorColor: Colors.blueGrey,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nova lozinka',
                  hintStyle: TextStyle(color: Colors.blueGrey)
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]
              ),
              width: double.infinity,
              child: const TextField(
                cursorColor: Colors.blueGrey,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ponovite novu lozinku',
                  hintStyle: TextStyle(color: Colors.blueGrey)
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: MaterialButton(
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.black87,
                onPressed: (){
      
                },
                child: const Text("SAČUVAJ", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),),
              ),
            )
          ],
        ),
      ),
    );
  }
}