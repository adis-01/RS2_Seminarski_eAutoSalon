import 'package:flutter/material.dart';

class CommentDialog extends StatefulWidget {
  const CommentDialog({super.key});

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.comment, size: 25, color: Colors.black87,),
                IconButton(
                  splashRadius: 20,
                  onPressed: (){
                  Navigator.of(context).pop();
                }, icon: const Icon(Icons.close, size: 25, color: Colors.black87,))
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300]
              ),
              child: TextField(
                controller: _commentController,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Unesite komentar...',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black87
                ),
                child: const Text("SAČUVAJ", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
              ),
            )
          ],
        ),
      ),
    );
  }
}