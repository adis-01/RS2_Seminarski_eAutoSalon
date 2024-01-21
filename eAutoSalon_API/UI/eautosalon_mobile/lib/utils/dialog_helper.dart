
import 'package:flutter/material.dart';

class MyDialogs{
  static Future<void> showQuestion(BuildContext context, String question, VoidCallback onYes) async{
    return showDialog(
      context: context, 
      builder: (context) => 
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                )
              ),
              child: const Center(child: Icon(Icons.question_mark_outlined, size: 35, color: Colors.white,)),
            ),
            const SizedBox(height: 15),
            Text(question, textAlign: TextAlign.center ,style: const TextStyle(fontSize: 17, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: onYes,
                   child: const Text("DA", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                ),
                const SizedBox(width: 40),
                MaterialButton(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                   child: const Text("NE", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                )
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      )
    );
  }


  static Future<void> showSuccess(BuildContext context, String message, VoidCallback onOk) async{
    return showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) =>
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                )
              ),
              child: const Center(child: Icon(Icons.check_circle, color: Colors.white, size: 35,)),
            ),
            const SizedBox(height: 15),
            Text(message, textAlign: TextAlign.center ,style: const TextStyle(fontSize: 17, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
            const SizedBox(height: 25),
            Center(
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(10),
                color: Colors.black87,
                onPressed: onOk,
                child: const Text("OK", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            ),
            const SizedBox(height: 8,)
          ],
        ),
      )
    );
  }



  static Future<void> showError(BuildContext context, String message) async{
    return showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) =>
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                )
              ),
              child: const Center(child: Icon(Icons.cancel, color: Colors.white, size: 35,)),
            ),
            const SizedBox(height: 15),
            Text(message, textAlign: TextAlign.center ,style: const TextStyle(fontSize: 17, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
            const SizedBox(height: 25),
            Center(
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(10),
                color: Colors.black87,
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text("OK", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            ),
            const SizedBox(height: 8,)
          ],
        ),
      )
    );
  }
}