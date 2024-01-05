import 'package:flutter/material.dart';

class CustomDialogs {
  static Future<void> showError(BuildContext context, String text) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              actionsAlignment: MainAxisAlignment.center,
              content: 
              Column(mainAxisSize: MainAxisSize.min, children: [
               
                    Icon(
                      Icons.error_rounded,
                      color: Colors.red[400],
                      size: 45,
                    ),
                
                const Text(
                  'Error',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      letterSpacing: 1,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                ),
              ]),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 40),
                      backgroundColor:const Color(0xFF0F6BAE)),
                    child: const Text('OK',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.2)),
                  ),
                )
              ],
            ));
  }

  static Future<void> showQuestion(
      BuildContext context, String question, VoidCallback onYes) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.5),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              icon: const Icon(Icons.question_mark_sharp,
                  color: Color(0xFF0F6BAE), size: 45),
              iconPadding: const EdgeInsets.all(20.5),
              content: (Wrap(
                children: [
                  Text(
                    question,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                        color: Colors.blueGrey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.blueGrey,
                    thickness: 0.3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(80, 40),
                    backgroundColor: const Color(0xFF248BD6),
                  ),
                  child: const Text('Poništi'),
                ),
                ElevatedButton(
                    onPressed: () {
                      onYes();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(80, 40),
                        backgroundColor: const Color(0xFF248BD6)),
                    child: const Text('Da')),
              ],
            ));
  }

  static Future<void> showSuccess(
      BuildContext context, String message, VoidCallback onYes) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.5),
              ),
              actionsAlignment: MainAxisAlignment.center,
              icon: const Icon(
                Icons.check_circle,
                size: 45,
              ),
              iconColor: Colors.green[400],
              iconPadding: const EdgeInsets.all(20.5),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      message,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                          color: Colors.blueGrey),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.blueGrey,
                    thickness: 0.3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    onYes();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 40),
                      backgroundColor: const Color(0xFF0F6BAE)),
                  child: const Text('OK'),
                )
              ],
            ));
  }
}
