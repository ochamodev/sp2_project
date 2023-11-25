import 'package:json_annotation/json_annotation.dart';

part 'customer_retention_item_response.g.dart';

@JsonSerializable()
class CustomerRetentionItemResponse {
  @JsonKey(name: "monthT")
  final int monthT;
  @JsonKey(name: "yearT")
  final int yearT;
  @JsonKey(name: "newClients")
  final int newClients;
  @JsonKey(name: "newAmount")
  final String newAmount;
  @JsonKey(name: "cancelledClients")
  final int cancelledClients;
  @JsonKey(name: "cancelledAmount")
  final String cancelledAmount;
  @JsonKey(name: "retainedClients")
  final int retainedClients;
  @JsonKey(name: "retainedAmount")
  final String retainedAmount;
  @JsonKey(name: "customerRetention")
  final String customerRetention;


  CustomerRetentionItemResponse({
    required this.yearT,
    required this.monthT,
    required this.newClients,
    required this.newAmount,
    required this.cancelledClients,
    required this.cancelledAmount,
    required this.retainedClients,
    required this.retainedAmount,
    required this.customerRetention,
  });

  factory CustomerRetentionItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerRetentionItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRetentionItemResponseToJson(this);

}
