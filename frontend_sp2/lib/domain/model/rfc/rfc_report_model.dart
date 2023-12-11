
import 'package:equatable/equatable.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_item.dart';
import 'package:frontend_sp2/domain/model/rfc/rfc_summary_card_model.dart';
import 'package:frontend_sp2/domain/model/year_filter_model.dart';

class RFCReportModel extends Equatable {
// modelar propiedades indepedientes

  final List<SummaryCardModel> generalSummary;
  final List<RFCItem> reportList;

  RFCReportModel({
    required this.generalSummary,
    required this.reportList
  });

  @override
  List<Object?> get props => [
    generalSummary,
    reportList
  ];

  RFCReportModel copyWith({
    List<SummaryCardModel>? generalSummary,
    List<YearFilterModel>? yearFilters,
    List<RFCItem>? reportList,
  }) {
    return RFCReportModel(
        generalSummary: generalSummary ?? this.generalSummary,
        reportList: reportList ?? this.reportList
    );
  }
}