
import 'package:eautosalon_mobile/models/finished_business.dart';
import 'package:eautosalon_mobile/providers/base_provider.dart';

class FinishedBusinessProvider extends BaseProvider<FinishedBusiness>{


  FinishedBusinessProvider() : super("ZavrseniPoslovi");

  @override
  FinishedBusiness fromJson(object) {
    return FinishedBusiness.fromJson(object);
  }
}