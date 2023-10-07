
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/core/network_call_methods.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

class FileUploadCaller {
  final Dio dio;
  final Logger logger;

  FileUploadCaller({
    required this.dio,
    required this.logger
  });

  Future<Either<Exception, BaseResponse>> uploadFile(File file) async {
    var fileName = file.path.split('/').last;
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType(
              'application',
              'vnd.openxmlformats-officedocument.spreadsheetml.sheet'
          )
      )
    });
    try {
      var response = await Dio().post(
          NetworkCallMethods.fileUpload,
          options: Options(contentType: 'multipart/form-data'),
          data: formData
      );
      return Either.right(BaseResponse.fromJson(response.data));
    } catch (e) {
      logger.e(e);
      return Either.left(e as Exception);
    }
  }

  Future<Either<Exception, BaseResponse>> uploadFileBytes(Uint8List file) async {
    var formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
          file,
          contentType: MediaType(
              'application',
              'vnd.ms-excel'
          ),
          filename: "ventas.xls"
      )
    });
    try {
      var response = await dio.post(
          NetworkCallMethods.fileUpload,
          data: formData
      );
      return Either.right(BaseResponse.fromJson(response.data));
    } catch (e) {
      logger.e(e);
      return Either.left(e as Exception);
    }
  }

}