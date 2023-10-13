import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:frontend_sp2/data/response/sales_performance_elements.dart';
import 'package:logger/logger.dart';

import 'model/sales_performance_request.dart';

class SalesPerformanceCaller{

  final Dio dio;
  final Logger logger;

  SalesPerformanceCaller({
    required this.dio,
    required this.logger,
  });

  Future getSales({required int year}) async {
    final String response = await rootBundle
        .loadString('assets/dummy_data/sales_performance_dummy_data.json');
    final data = await json.decode(response);

    return data;
  }


  Future<Either<Exception, SalesPerformanceElements>> annualSales({dynamic json}) async {

    List<SalesPerformanceModel> salesPerformances = [];

    try {

      for (String year in json.keys) {
        final Map<int, Map<String, num>> data = {};

        final List<int> months =
        json[year].keys.map((e) => int.parse(e)).toList().cast<int>();

        for (int month in months) {
          data[month] = {
            "amount": json[year][month.toString()]["amount"],
            "quantity": json[year][month.toString()]["quantity"],
          };
        }

        salesPerformances
            .add(SalesPerformanceModel(year: int.parse(year), data: data));
      }

      return Either.right(salesPerformances as SalesPerformanceElements);

    } catch (e) {
      logger.e(e);
      return Either.left(e as Exception);
    }

  }


}