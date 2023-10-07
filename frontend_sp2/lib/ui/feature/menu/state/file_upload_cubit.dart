
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_sp2/domain/file_upload_use_case.dart';
import 'package:logger/logger.dart';

part 'file_upload_cubit.freezed.dart';


class FileUploadCubit extends Cubit<FileUploadScreenState> {
  final FileUploadCallerUseCase _fileUploadCallerUseCase;
  final Logger _logger;

  FileUploadCubit(this._fileUploadCallerUseCase, this._logger) : super(_Initial());

  void resetView() {
    emit(_Initial());
  }

  Future<void> uploadFileBytes(Uint8List file) async {
    _logger.d("Cargando archivo");
    emit(
        _Loading()
    );

    final result = await _fileUploadCallerUseCase.callWithBytes(file);

    result.match((error) {
      _logger.e(error);
      emit(
        _Error()
      );
    }, (result) {
      emit(
        _Success()
      );
    });
  }

}

@freezed
class FileUploadScreenState with _$FileUploadScreenState {
  factory FileUploadScreenState.initial() = _Initial;

  factory FileUploadScreenState.loading() = _Loading;

  factory FileUploadScreenState.error() = _Error;

  factory FileUploadScreenState.success() = _Success;
}