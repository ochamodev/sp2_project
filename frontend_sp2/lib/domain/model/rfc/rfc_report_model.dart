import 'package:equatable/equatable.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_item.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_report_model_elements.dart';

class RFCReportModel {
  final List<RFCItem> reportList;

  RFCReportModel({
    required this.reportList
  });

  @override
  List<Object?> get props => [
    reportList
  ];

  RFCReportModel copyWith({
    List<RFCItem>? reportList
  }) {
    return RFCReportModel(
        reportList: reportList ?? this.reportList
    );
  }

}

