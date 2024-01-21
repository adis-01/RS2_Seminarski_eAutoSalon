import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Novosti',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buildFilterTypes(),
                    const SizedBox(height: 25),
                    buildNewsContainer(),
                    buildNewsContainer(),
                    buildNewsContainer(),
                    buildNewsContainer(),
                    buildNewsContainer(),
                    buildNewsContainer(),
                  ],
                ),
                Column(
                  children: [buildPagingArrows()],
                )
              ],
            ),
          ),
        ));
  }

  Container buildNewsContainer() {
    return Container(
      height: 235,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white70),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text(
                        "Google is redefining mobile with artificial intelligence",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Owen Williams",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "12 SEP 2018",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.black87,
                        onPressed: (){

                        },
                        child: const Icon(Icons.more_horiz, color: Colors.white,)),
                    ],
                  )
                ],
              )),
          const SizedBox(width: 10),
          const Expanded(flex: 1, child: Placeholder())
        ],
      ),
    );
  }

  Row buildFilterTypes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              index = 1;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: Text(
              "Sve",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: index == 1 ? Colors.black54 : Colors.white),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              index = 2;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: Text(
              "Novosti",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: index == 2 ? Colors.black54 : Colors.white),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              index = 3;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: Text(
              "Kolumne",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: index == 3 ? Colors.black54 : Colors.white),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              index = 4;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: Text(
              "Recenzije",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: index == 4 ? Colors.black54 : Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Row buildPagingArrows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60,
          height: 40,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.black87,
            disabledColor: Colors.grey[400],
            padding: const EdgeInsets.all(5),
            onPressed: () {},
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          "1/1",
          style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        SizedBox(
          width: 60,
          height: 40,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.black87,
            disabledColor: Colors.grey[400],
            padding: const EdgeInsets.all(5),
            onPressed: () {},
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
