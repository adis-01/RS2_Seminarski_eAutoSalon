
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class NewCarAccessories extends StatefulWidget {
  const NewCarAccessories({super.key});

  @override
  State<NewCarAccessories> createState() => _NewCarAccessoriesState();
}

class _NewCarAccessoriesState extends State<NewCarAccessories> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Dodatna oprema', 
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  shape: const CircleBorder(),
                  color: const Color(0xFF248BD6),
                  onPressed: (){
                    Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, size: 25, color: Colors.white,),
                )
              ],
            )
          ],
        ),
      )
      );
  }
}