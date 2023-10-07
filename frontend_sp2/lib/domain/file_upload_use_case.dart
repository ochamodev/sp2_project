

import 'dart:io';
import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:frontend_sp2/data/file_upload_caller.dart';
import 'package:frontend_sp2/data/response/base_response.dart';
import 'package:frontend_sp2/data/response/response_code.dart';

class FileUploadCallerUseCase {
  final FileUploadCaller _fileUploadCaller;

  FileUploadCallerUseCase(this._fileUploadCaller);

  // TODO: Use ResponseCode instead
  Future<Either<Exception, BaseResponse>> call(File file) async {
    return _fileUploadCaller.uploadFile(file);
  }

  // TODO: Use ResponseCode instead
  Future<Either<Exception, BaseResponse>> callWithBytes(Uint8List file) async {
    return _fileUploadCaller.uploadFileBytes(file);
  }

}