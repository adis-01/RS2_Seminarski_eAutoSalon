
import 'package:eautosalon_mobile/models/transaction.dart';

import 'base_provider.dart';

class TransactionProvider extends BaseProvider<Transaction>{

  TransactionProvider() : super("Transakcije");

  @override
  Transaction fromJson(object) {
    return Transaction.fromJson(object);
  }
}