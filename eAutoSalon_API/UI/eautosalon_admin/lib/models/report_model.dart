
import 'package:eautosalon_admin/models/report_dto.dart';
import 'package:intl/intl.dart';

class ReportModel{
  List<ReportDto> list = [];
  double? iznos;

  String get formattedPrice { return NumberFormat.currency(locale: 'en_US', symbol: '').format(iznos);}
}