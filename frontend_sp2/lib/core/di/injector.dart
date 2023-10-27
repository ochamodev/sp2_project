
import 'package:dio/dio.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/navigation/main_menu_guard.dart';
import 'package:frontend_sp2/data/base_api_caller.dart';
import 'package:frontend_sp2/data/customer_lifetime_value_caller.dart';
import 'package:frontend_sp2/data/file_upload_caller.dart';
import 'package:frontend_sp2/data/year_filter_api_caller.dart';
import 'package:frontend_sp2/domain/customer_lifetime_value_use_case.dart';
import 'package:frontend_sp2/domain/file_upload_use_case.dart';
import 'package:frontend_sp2/domain/login_use_case.dart';
import 'package:frontend_sp2/domain/logout_use_case.dart';
import 'package:frontend_sp2/domain/register_user_use_case.dart';
import 'package:frontend_sp2/domain/sales_performance_use_case.dart';
import 'package:frontend_sp2/domain/user_authenticated_use_case.dart';
import 'package:frontend_sp2/ui/feature/login/state/login_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/cubit/main_menu_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/state/customer_lifetime_value_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/state/file_upload_cubit.dart';
import 'package:frontend_sp2/ui/feature/register/state/register_user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/sales_performance_caller.dart';
import '../../ui/feature/menu/state/sales_performance_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeInjectedDependencies() async {

  getIt.registerLazySingleton(() => Logger());
  getIt.registerSingleton(await SharedPreferences.getInstance());
  getIt.registerSingleton(AppRouter());
  getIt.registerSingleton(setupDio());

  // api callers
  getIt.registerSingleton(BaseApiCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(FileUploadCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(SalesPerformanceCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(CustomerLifetimeValueCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(YearFilterApiCaller(dio: getIt(), logger: getIt()));
  // use cases
  getIt.registerSingleton(LoginUseCase(getIt()));
  getIt.registerSingleton(RegisterUserUseCase(getIt()));
  getIt.registerSingleton(FileUploadCallerUseCase(getIt()));
  getIt.registerSingleton(LogoutUseCase(getIt()));
  getIt.registerSingleton(UserAuthenticatedUseCase(getIt()));
  getIt.registerSingleton(SalesPerformanceUseCase(getIt()));
  getIt.registerSingleton(CustomerLifetimeValueUseCase(getIt(), getIt(), getIt()));
  // blocs factories
  getIt.registerFactory(() => LoginCubit(getIt(), getIt()));
  getIt.registerFactory(() => RegisterUserCubit(getIt()));
  getIt.registerFactory(() => FileUploadCubit(getIt(), getIt()));
  getIt.registerFactory(() => MainMenuCubit(getIt()));
  getIt.registerFactory(() => SalesPerformanceCubit(getIt(), getIt()));
  getIt.registerFactory(() => CustomerLifetimeValueCubit(getIt(), getIt()));
  // guards
  getIt.registerSingleton(MainMenuGuard(getIt()));

}

Dio setupDio() {
  final dio = Dio();
  dio.options.baseUrl = 'http://127.0.0.1:5000';
  dio.options.connectTimeout = const Duration(seconds: 20);
  dio.options.receiveTimeout = const Duration(seconds: 20);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      if (options.path != '/user/login' && options.path != '/user/register') {
        var sharedPrefs = getIt<SharedPreferences>();
        String accessToken = sharedPrefs.getString('at') ?? "";

        options.headers['Authorization'] = 'Bearer $accessToken';
      }

      // Proceed with the request
      handler.next(options);
    },
  ));

  return dio;
}
