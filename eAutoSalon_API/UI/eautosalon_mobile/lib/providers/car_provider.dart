
import '../models/car.dart';
import 'base_provider.dart';

class CarProvider extends BaseProvider<Car>{
  CarProvider() : super("Automobil");

  @override
  Car fromJson(object) {
    return Car.fromJson(object);
  }
}