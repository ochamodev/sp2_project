import 'package:frontend_sp2/data/response/customer_lifetime_value_item_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_lifetime_value_response.g.dart';

@JsonSerializable()
class CustomerLifetimeValueResponse {
  final String avgFrequencyMonth;
  final String avgMonthActive;
  final String avgPurchase;
  final int totalClient;
  final Map<String, List<CustomerLifetimeValueItemResponse>> customerValuePerYear;

  CustomerLifetimeValueResponse({
    required this.avgFrequencyMonth,
    required this.avgMonthActive,
    required this.avgPurchase,
    required this.totalClient,
    required this.customerValuePerYear,
  });

  factory CustomerLifetimeValueResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerLifetimeValueResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerLifetimeValueResponseToJson(this);

}