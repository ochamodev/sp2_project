import 'package:frontend_sp2/domain/model/rfc/rfc_report_model_elements.dart';

class RFCItem {
  final int clusterId;
  final String clusterName;
  final List<RFCReportModelElements> elements;

  RFCItem({
    required this.clusterId,
    required this.clusterName,
    required this.elements,
  });
}