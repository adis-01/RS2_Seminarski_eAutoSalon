import 'package:flutter/material.dart';

class CustomDialogs {
  static Future<void> showError(BuildContext context, String text) async {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: SizedBox(
                width: 450,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                      ),
                      child: Center(
                        child: Column(
                          children: const [
                            Icon(Icons.error_outline,
                                size: 40, color: Colors.white),
                            SizedBox(height: 10),
                            Text("ERROR",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 3))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey))),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: 150,
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(15),
                            color: Colors.blueGrey,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white)))),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ));
  }

  static Future<void> showQuestion(
      BuildContext context, String question, VoidCallback onYes) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          child: SizedBox(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                  ),
                  child: Center(
                    child: Column(
                      children: const [
                        Icon(Icons.question_mark_outlined, size: 50, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(padding: const EdgeInsets.all(15),child: Text(question, textAlign: TextAlign.center,style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 130,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(15),
                        color: Colors.blueGrey,
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ne", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(15),
                        color: Colors.blueGrey,
                        onPressed: onYes,
                        child: const Text("Da", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ));
  }

  static Future<void> showSuccess(
      BuildContext context, String message, VoidCallback onYes) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
              child: SizedBox(
                width: 450,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                      ),
                      child: Center(
                        child: Column(
                          children: const [
                            Icon(Icons.check_circle_rounded,
                                size: 40, color: Colors.white),
                            SizedBox(height: 10),
                            Text("SUCCESS",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 3))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                        padding: const EdgeInsets.all(15),
                        child: Text(message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey))),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: 150,
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(15),
                            color: Colors.blueGrey,
                            onPressed: onYes,
                            child: const Text("OK",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white)))),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ));
  }
}
