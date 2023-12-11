
import 'package:frontend_sp2/domain/model/rfc/rfc_report_model_elements.dart';

class RFCItem {
  final List<double> recencyValues;
  final List<double> frequencyValues;
  final List<double> monetaryValues;
  final List<double> rfmScoreValues;
  final List<String> clusterNames;
  final List<String> uniqueClusterNames;
  final List<RFCReportModelElements> elements;

  RFCItem({
    required this.recencyValues,
    required this.frequencyValues,
    required this.monetaryValues,
    required this.rfmScoreValues,
    required this.clusterNames,
    required this.uniqueClusterNames,
    required this.elements,
  });

}

