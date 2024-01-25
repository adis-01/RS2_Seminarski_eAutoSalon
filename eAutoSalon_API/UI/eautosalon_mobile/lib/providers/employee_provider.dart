
import 'package:eautosalon_mobile/providers/base_provider.dart';

import '../models/employee.dart';

class EmployeeProvider extends BaseProvider<Employee>{
  
  EmployeeProvider() : super("Uposlenici");

  @override
  Employee fromJson(object) {
    return Employee.fromJson(object);
  }
}