
import 'package:eautosalon_admin/models/report_dto.dart';
import 'package:eautosalon_admin/providers/base_provider.dart';

class ReportProvider extends BaseProvider<ReportDto>{
  ReportProvider() : super("ZavrseniPoslovi");

  @override
  ReportDto fromJson(data) {
    return ReportDto.fromJson(data);
  }
}