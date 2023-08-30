
import 'package:dio/dio.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

Future<void> initializeInjectedDependencies() async {

  getIt.registerLazySingleton(() => Logger());
  getIt.registerSingleton(AppRouter());
  getIt.registerSingleton(setupDio());

}

Dio setupDio() {
  final dio = Dio();
  dio.options.baseUrl = '127.0.0.1:5000/';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  return dio;
}
