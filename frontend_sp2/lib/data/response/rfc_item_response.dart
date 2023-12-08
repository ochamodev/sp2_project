
import 'package:json_annotation/json_annotation.dart';

part 'rfc_item_response.g.dart';

@JsonSerializable()
class RFCItemResponse {
  @JsonKey(name: "idReceptor")
  final int idReceptor;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "amount")
  final String amount;
  @JsonKey(name: "rfm_score")
  final String rfmScore;
  @JsonKey(name: "recency")
  final String recency;
  @JsonKey(name: "frequency")
  final String frequency;
  @JsonKey(name: "monetary")
  final String monetary;
  @JsonKey(name: "cluster")
  final int cluster;
  @JsonKey(name: "cluster_name")
  final String clusterName;

  RFCItemResponse({
    required this.idReceptor,
    required this.name,
    required this.amount,
    required this.rfmScore,
    required this.recency,
    required this.frequency,
    required this.monetary,
    required this.cluster,
    required this.clusterName,
  });

  factory RFCItemResponse.fromJson(Map<String, dynamic> json) =>
      _$RFCItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RFCItemResponseToJson(this);
}
