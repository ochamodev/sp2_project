import 'package:frontend_sp2/data/response/rfc_item_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rfc_response.g.dart';

@JsonSerializable()
class RFCResponse {

  final double avgFrequency;
  final double avgMonetary;
  final double avgRecency;
  final Map<String, List<RFCItemResponse>> customerClusters;

  RFCResponse({
    required this.avgFrequency,
    required this.avgMonetary,
    required this.avgRecency,
    required this.customerClusters,
  });

  factory RFCResponse.fromJson(Map<String, dynamic> json) =>
      _$RFCResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RFCResponseToJson(this);
}
