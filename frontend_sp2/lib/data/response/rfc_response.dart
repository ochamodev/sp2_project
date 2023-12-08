import 'package:frontend_sp2/data/response/rfc_item_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rfc_response.g.dart';

@JsonSerializable()
class RFCResponse {
  final Map<String, List<RFCItemResponse>> premium;
  final Map<String, List<RFCItemResponse>> potential;
  final Map<String, List<RFCItemResponse>> sporadic;

  RFCResponse({
    required this.premium,
    required this.potential,
    required this.sporadic,
  });

  factory RFCResponse.fromJson(Map<String, dynamic> json) =>
      _$RFCResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RFCResponseToJson(this);
}
