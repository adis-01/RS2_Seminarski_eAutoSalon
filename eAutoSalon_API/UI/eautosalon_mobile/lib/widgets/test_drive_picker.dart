import 'package:flutter/material.dart';
class TestDriveDialog extends StatefulWidget {
  const TestDriveDialog({super.key});

  @override
  State<TestDriveDialog> createState() => _TestDriveDialogState();
}

class _TestDriveDialogState extends State<TestDriveDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("PROIZVOĐAČ MODEL", style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w400),),
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: const Icon(Icons.close, size: 25, color: Colors.black87,))
              ], 
            ),
            const SizedBox(height: 5),
            const Text("Odaberite termin", style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500, fontSize: 14),),
            const SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }
}