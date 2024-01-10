
import 'package:eautosalon_admin/models/car.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';

class CarProvider extends BaseProvider<Automobil>{
  CarProvider() : super("Automobili");

  @override
  Automobil fromJson(data) {
    return Automobil.fromJson(data);
  }
}