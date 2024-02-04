import 'package:eautosalon_admin/models/transactions.dart';
import 'package:eautosalon_admin/providers/transaction_provider.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  List<Transakcija> list = [];
  bool isLoading=true;
  late TransakcijaProvider _transakcijaProvider;


  // List<Transakcija> lista = [
  //   Transakcija('px_3213219fNAFNK21ll', '32852.0', 'USD'),
  //   Transakcija('pjdasn23_321k231čalsas', '2244.0', 'BAM'),
  //   Transakcija('XK_dsakn21kj0asjkl', '2143.0', 'USD'),
  //   Transakcija('XK_dsakn21kj0asjkl', '2143.0', 'USD'),
  //   Transakcija('XK_dsakn21kj0asjkl', '2143.0', 'USD'),
  //   Transakcija('XK_dsakn21kj0asjkl', '2143.0', 'USD'),
  //   Transakcija('XK_dsakn21kj0asjkl', '2143.0', 'USD'),
  //   Transakcija('XK_dsakn21kj0asjkl', '2143.0', 'USD'),
  //   Transakcija('XK_dsakn21kj0asjkl', '2143.0', 'USD'),
  //   Transakcija('XK_dsakn21kj0asjkl', '2143.0', 'USD'),
  // ];

  @override
  void initState() {
    super.initState();
    _transakcijaProvider=context.read<TransakcijaProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Transakcije',
        body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),) 
         :
         SingleChildScrollView(
           child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                        color: Colors.blueGrey,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => const HomePageScreen()));
                        },
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 26,))
                  ],
                ),
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    width: 650,
                    height: 550,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70),
                    child: list.isNotEmpty ? SingleChildScrollView(
                      child: Column(
                        children: list.map((Transakcija item) => buildTransactionTile(item)).toList()
                      ),
                    ) : const Center(child: Text("Trenutno nema transakcija", style: TextStyle(fontSize: 16, color: Colors.black54, wordSpacing: 1, fontWeight: FontWeight.w500),)),
                  ),
                
              ],
            ),
                 ),
         ),
        floatingEnabled: false);
  }

  Container buildTransactionTile(Transakcija object) {
    return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[500]),
                        child: 
                            SizedBox(
                              width: double.infinity,
                              child: ListTile(
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.white),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.payment,
                                    color: Colors.white70,
                                  )),
                                ),
                                title: Text("\$${object.iznos}", style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),),
                                subtitle: Text(object.valuta?.toUpperCase() ?? "null", style: const TextStyle(fontSize: 16, color: Colors.white70, letterSpacing: 1.5, fontWeight: FontWeight.w500),),
                                trailing: Tooltip(message: 'Broj transakcije',child: Text("${object.brojTransakcije}", style: const TextStyle(fontSize: 15,letterSpacing: 0.5, fontWeight: FontWeight.w500, color: Colors.white),)),
                              ),
                            ),
                        );
  }
  
  Future<void> fetchData() async{
    try {
      var data = await _transakcijaProvider.getTransakcije();
      setState(() {
        list=data;
        isLoading=false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
