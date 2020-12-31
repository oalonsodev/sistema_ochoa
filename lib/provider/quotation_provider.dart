import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/models/quotation_model.dart';

class QuotationProvider with ChangeNotifier {
  /// La instancia de la cotización actual.
  QuotationModel quotation = new QuotationModel();

  /// Restaurar los datos de la cotización.
  void resetQuotation() {
    quotation = new QuotationModel();
  }
}
