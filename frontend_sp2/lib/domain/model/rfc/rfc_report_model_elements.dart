import 'package:equatable/equatable.dart';

class RFCReportModelElements extends Equatable {
  final int idClient;
  final String name;
  final double amount;
  final double rfmScore;
  final double recency;
  final double frequency;
  final double monetary;
  final int clusterId;
  final String clusterName;

  const RFCReportModelElements({
    required this.idClient,
    required this.name,
    required this.amount,
    required this.rfmScore,
    required this.recency,
    required this.frequency,
    required this.monetary,
    required this.clusterId,
    required this.clusterName,
  });

  @override
  List<Object?> get props => [
    idClient,
    name,
    amount,
    rfmScore,
    recency,
    frequency,
    monetary,
    clusterId,
    clusterName,
  ];
}
