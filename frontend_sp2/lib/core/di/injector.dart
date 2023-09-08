
import 'package:dio/dio.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/data/base_api_caller.dart';
import 'package:frontend_sp2/domain/login_use_case.dart';
import 'package:frontend_sp2/domain/register_user_use_case.dart';
import 'package:frontend_sp2/ui/feature/login/state/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initializeInjectedDependencies() async {

  getIt.registerLazySingleton(() => Logger());
  getIt.registerSingleton(AppRouter());
  getIt.registerSingleton(setupDio());
  getIt.registerSingleton(await SharedPreferences.getInstance());

  // api callers
  getIt.registerSingleton(BaseApiCaller(dio: getIt(), logger: getIt()));

  // use cases
  getIt.registerSingleton(LoginUseCase(getIt()));
  getIt.registerSingleton(RegisterUserUseCase(getIt()));

  // blocs factories
  getIt.registerFactory(() => LoginCubit(getIt(), getIt()));

}

Dio setupDio() {
  final dio = Dio();
  dio.options.baseUrl = '127.0.0.1:5000/';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  return dio;
}
