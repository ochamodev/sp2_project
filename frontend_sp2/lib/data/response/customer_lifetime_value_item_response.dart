
import 'package:json_annotation/json_annotation.dart';

part 'customer_lifetime_value_item_response.g.dart';

@JsonSerializable()
class CustomerLifetimeValueItemResponse {
  @JsonKey(name: "amount")
  final String amount;
  @JsonKey(name: "customerValue")
  final String customerValue;
  @JsonKey(name: "purchaseRate")
  final String purchaseRate;
  @JsonKey(name: "purchaseValue")
  final String purchaseValue;
  @JsonKey(name: "clientCount")
  final int clientCount;
  @JsonKey(name: "monthT")
  final int monthT;
  @JsonKey(name: "yearT")
  final int yearT;
  @JsonKey(name: "quantity")
  final int quantity;

  CustomerLifetimeValueItemResponse({
    required this.amount,
    required this.yearT,
    required this.customerValue,
    required this.purchaseRate,
    required this.purchaseValue,
    required this.clientCount,
    required this.monthT,
    required this.quantity,
  });

  factory CustomerLifetimeValueItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerLifetimeValueItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerLifetimeValueItemResponseToJson(this);

}