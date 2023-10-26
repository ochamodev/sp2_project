
import 'package:json_annotation/json_annotation.dart';

part 'customer_lifetime_value_item_response.g.dart';

@JsonSerializable()
class CustomerLifetimeValueItemResponse {
  final String amount;
  final String customerValue;
  final String purchaseRate;
  final String purchaseValue;
  final int clientCount;
  final int monthT;
  final int quantity;

  CustomerLifetimeValueItemResponse({
    required this.amount,
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