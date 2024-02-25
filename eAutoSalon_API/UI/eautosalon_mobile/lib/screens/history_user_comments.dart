import 'package:eautosalon_mobile/models/comment_history.dart';
import 'package:eautosalon_mobile/providers/comment_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryComments extends StatefulWidget {
  final int korisnikId;
  const HistoryComments({super.key, required this.korisnikId});

  @override
  State<HistoryComments> createState() => _HistoryCommentsState();
}

class _HistoryCommentsState extends State<HistoryComments> {
  bool isLoading = true;
  late List<KomentarHistorija> list = [];
  late KomentarProvider _komentarProvider;

  @override
  void initState() {
    super.initState();
    _komentarProvider = context.read<KomentarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Vaši komentari',
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black87,
                    ),
                  )
                : SingleChildScrollView(
                    child: list.isNotEmpty
                        ? Column(
                            children: list
                                .map((KomentarHistorija item) =>
                                    buildCommentBox(item))
                                .toList(),
                          )
                        : noDataContainer(),
                  )));
  }

  Container buildCommentBox(KomentarHistorija comment) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.newspaper,
            size: 22,
            color: Colors.grey[800],
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            comment.naslov?.toUpperCase() ?? "null",
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text(
            comment.sadrzaj ?? "null",
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Center noDataContainer() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/car_icon.png",
            width: 100,
            height: 90,
          ),
          const SizedBox(height: 15),
          const Text(
            "Do sada niste ostavili nijedan komentar.",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 17,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      var data = await _komentarProvider.getHistory(widget.korisnikId);
      if (mounted) {
        setState(() {
          list = data;
          isLoading = false;
        });
      }
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
