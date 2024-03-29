// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/providers/comment_provider.dart';
import 'package:eautosalon_admin/screens/news_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCommentDialog extends StatefulWidget {
  int? novostId;
  NewCommentDialog({super.key, required this.novostId});

  @override
  State<NewCommentDialog> createState() => _NewCommentDialogState();
}

class _NewCommentDialogState extends State<NewCommentDialog> {
  late int userID;
  late KomentarProvider _komentarProvider;
  final _commentController = TextEditingController();
  bool buttonDisabled = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _komentarProvider = context.read<KomentarProvider>();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[300],
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 500,
        child: isLoading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [Center(child: CircularProgressIndicator())])
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.comment, size: 25, color: Colors.blueGrey),
                      IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.blueGrey,
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: TextField(
                        cursorColor: Colors.grey,
                        controller: _commentController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Napišite komentar...',
                        ),
                        maxLines: null,
                        onChanged: (value) {
                          setState(() {
                            buttonDisabled = value.isEmpty || value.startsWith(" ");
                          });
                        },
                      )),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: MaterialButton(
                            color: Colors.blueGrey,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onPressed: buttonDisabled
                                ? null
                                : () {
                                    dynamic request = {
                                      'Sadrzaj': _commentController.text,
                                      'KorisnikId': userID,
                                      'NovostiId': widget.novostId,
                                      'State' : 'Aktivan'
                                    };
                                    saveData(request);
                                  },
                            child: !buttonDisabled
                                ? const Text("Spasi",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white))
                                : null),
                      )
                    ],
                  )
                ],
              ),
      ),
    );
  }

  Future<void> loadData() async {
    try {
      var data = await _komentarProvider.getUserId();
      setState(() {
        userID = data;
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }

  Future<void> saveData(dynamic obj) async {
    try {
      await _komentarProvider.insert(obj);
      CustomDialogs.showSuccess(context, 'Uspješno spremljen komentar', () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (builder) => const NewsScreen()));
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
