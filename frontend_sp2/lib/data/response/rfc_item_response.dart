
import 'package:json_annotation/json_annotation.dart';

part 'rfc_item_response.g.dart';

@JsonSerializable()
class RFCItemResponse {
  @JsonKey(name: "idReceptor")
  final int idReceptor;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "rfmScore")
  final double rfmScore;
  @JsonKey(name: "recency")
  final double recency;
  @JsonKey(name: "frequency")
  final double frequency;
  @JsonKey(name: "monetary")
  final double monetary;
  @JsonKey(name: "cluster")
  final int cluster;
  @JsonKey(name: "clusterName")
  final String clusterName;

  RFCItemResponse({
    required this.idReceptor,
    required this.name,
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
