import '../models/employee.dart';
import 'base_provider.dart';

class EmployeeProvider extends BaseProvider<Employee>{

  EmployeeProvider() : super("Uposlenici");
  

  @override
  Employee fromJson(data) {
    return Employee.fromJson(data);
  }

}