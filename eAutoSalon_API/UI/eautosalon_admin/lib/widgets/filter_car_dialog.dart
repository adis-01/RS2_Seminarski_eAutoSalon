import 'package:eautosalon_admin/providers/car_provider.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class FilterCarDialog extends StatefulWidget {
  const FilterCarDialog({super.key});

  @override
  State<FilterCarDialog> createState() => _FilterCarDialogState();
}

class _FilterCarDialogState extends State<FilterCarDialog> {
  late CarProvider _carProvider;
  bool isLoading = true;
  List<String> _listaProizvodjaca = [];
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _carProvider = context.read<CarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Colors.grey[300],
            child: SingleChildScrollView(
              child: Container(
                width: 700,
                padding: const EdgeInsets.all(15),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.filter_alt_rounded,
                            size: 27,
                            color: Colors.blueGrey,
                          ),
                          IconButton(
                              splashRadius: 27,
                              color: Colors.blueGrey,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 27,
                                color: Colors.blueGrey,
                              ))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          Container(
                            width: 300,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white60),
                            child: Column(
                              children: [
                                const Text("Proizvođač",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                                const SizedBox(height: 5),
                                FormBuilderDropdown(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: const EdgeInsets.all(15)),
                                  focusColor: Colors.grey[300],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.blueGrey),
                                  name: 'Proizvodjac',
                                  initialValue: "Svi",
                                  items: List.generate(
                                      _listaProizvodjaca.length,
                                      (index) => DropdownMenuItem(
                                            value: _listaProizvodjaca[index],
                                            child:
                                                Text(_listaProizvodjaca[index]),
                                          )),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 300,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white60),
                            child: Column(
                              children: [
                                const Text("Vrsta goriva",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                                const SizedBox(height: 5),
                                FormBuilderDropdown(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        contentPadding:
                                            const EdgeInsets.all(15)),
                                    focusColor: Colors.grey[300],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.blueGrey),
                                    name: 'TipGoriva',
                                    initialValue: "Svi",
                                    items: const [
                                      DropdownMenuItem(
                                        value: "Svi",
                                        child: Text("Svi"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Benzin",
                                        child: Text("Benzin"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Dizel",
                                        child: Text("Dizel"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Plin",
                                        child: Text("Plin"),
                                      ),
                                    ])
                              ],
                            ),
                          ),
                          Container(
                            width: 300,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white60),
                            child: Column(
                              children: [
                                const Text("Broj vrata",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                                const SizedBox(height: 5),
                                FormBuilderDropdown(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        contentPadding:
                                            const EdgeInsets.all(15)),
                                    focusColor: Colors.grey[300],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.blueGrey),
                                    name: 'BrojVrata',
                                    items: const [
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text("2/3"),
                                      ),
                                      DropdownMenuItem(
                                        value: 4,
                                        child: Text("4/5"),
                                      )
                                    ])
                              ],
                            ),
                          ),
                          buildNumberTextField(context, 'GodinaProizvodnje',
                              'Godina proizvodnje < od'),
                          buildNumberTextField(context, 'PredjenaKilometraza',
                              'Kilometraža < od'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      buildButtons(context)
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Container buildNumberTextField(
      BuildContext context, String name, String title) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white60),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueGrey),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: FormBuilderTextField(
              cursorColor: Colors.grey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.integer(context,
                    errorText: 'Samo cijeli brojevi su dozvoljeni')
              ]),
              name: name,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildButtons(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 42,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.blueGrey,
        padding: const EdgeInsets.all(15),
        onPressed: () {
          if (_formKey.currentState != null) {
            if (_formKey.currentState!.saveAndValidate()) {
              Navigator.of(context).pop(_formKey.currentState!.value);
            }
          }
        },
        child: const Text(
          "Pretraga",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      _listaProizvodjaca = await _carProvider.getProizvodjace();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
