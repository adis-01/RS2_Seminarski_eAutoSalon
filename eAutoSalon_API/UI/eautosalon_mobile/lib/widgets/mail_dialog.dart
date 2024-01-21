
import 'package:flutter/material.dart';

class MailDialog extends StatefulWidget {
  const MailDialog({super.key});

  @override
  State<MailDialog> createState() => _MailDialogState();
}

class _MailDialogState extends State<MailDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
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
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Mail',
                labelStyle: const TextStyle(color: Colors.black87),
                prefixIcon: const Icon(Icons.mail, color: Colors.black87,),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Sadržaj',
                labelStyle: const TextStyle(color: Colors.black87),
              ),
              minLines: 2,
              maxLines: 4,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: Colors.black87,
              padding: const EdgeInsets.all(10),
              onPressed: (){
          
              },
              child: const Text("POŠALJI", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),),),
          ),
            const SizedBox(height: 10),
        ],
      ),
    );
  }
}