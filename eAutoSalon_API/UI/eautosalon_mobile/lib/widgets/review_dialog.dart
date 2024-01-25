import 'package:eautosalon_mobile/providers/user_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({super.key});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {

  int currentRating = 1;
  final TextEditingController _commentController = TextEditingController();
  bool isLoading = true;
  late UserProvider _userProvider;
  int userId = 0;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black87,),)
          :
           Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.reviews, size: 25, color: Colors.black87,),
                  IconButton(
                    splashRadius: 20,
                    onPressed: (){
                      Navigator.of(context).pop();
                  }, icon: const Icon(Icons.close, size: 25, color: Colors.black87,))
                ],
              ),
              const SizedBox(height: 25),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    5, (index) => 
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentRating = index + 1;
                          });
                        },
                        child: Icon(Icons.star, size:27, color: index < currentRating ? Colors.yellow[800] : Colors.black54),
                      )
                    ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                child: TextField(
                  cursorColor: Colors.blueGrey,
                  controller: _commentController,
                  decoration: const InputDecoration(
                    counter: Icon(Icons.comment),
                    fillColor: Colors.black,
                    border: InputBorder.none,
                    hintText: 'Ukoliko želite, ostavite i komentar...',
                    hintStyle:  TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  minLines: 2,
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.black87,
                  onPressed: (){
                    Navigator.of(context).pop(
                      {
                        'Ocjena' : currentRating,
                        'Komentar' : _commentController.text,
                        'KorisnikId' : userId
                      }
                    );
                  }, child: const Text("SAČUVAJ", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),),),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> fetchData() async{
    try {
     var id = await _userProvider.getUserId();
     setState(() {
       userId=id;
       isLoading=false;
     });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}