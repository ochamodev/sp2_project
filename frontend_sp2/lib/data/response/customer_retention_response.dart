import 'package:frontend_sp2/data/response/customer_retention_item_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_retention_response.g.dart';

@JsonSerializable()
class CustomerRetentionResponse {
  final Map<String, List<CustomerRetentionItemResponse>> customerRetentionPerYear;

  CustomerRetentionResponse({
    required this.customerRetentionPerYear,
  });

  factory CustomerRetentionResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerRetentionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRetentionResponseToJson(this);

}