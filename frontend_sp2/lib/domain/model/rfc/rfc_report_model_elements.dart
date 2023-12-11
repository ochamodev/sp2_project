
import 'package:equatable/equatable.dart';

class RFCReportModelElements extends Equatable {
  final int cluster;
  final String clusterName;
  final int idReceptor;
  final String name;
  final double rfmScore;
  final double recency;
  final double frequency;
  final double monetary;

  const RFCReportModelElements({
    required this.idReceptor,
    required this.name,
    required this.rfmScore,
    required this.recency,
    required this.frequency,
    required this.monetary,
    required this.cluster,
    required this.clusterName,
  });

  @override
  List<Object?> get props => [
    idReceptor,
    name,
    rfmScore,
    recency,
    frequency,
    monetary,
    cluster,
    clusterName,
  ];
}