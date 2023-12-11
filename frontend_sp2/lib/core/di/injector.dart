
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:frontend_sp2/core/navigation/main_menu_guard.dart';
import 'package:frontend_sp2/data/base_api_caller.dart';
import 'package:frontend_sp2/data/customer_lifetime_value_caller.dart';
import 'package:frontend_sp2/data/customer_retention_caller.dart';
import 'package:frontend_sp2/data/file_upload_caller.dart';
import 'package:frontend_sp2/data/get_companies_caller.dart';
import 'package:frontend_sp2/data/get_users_in_company_caller.dart';
import 'package:frontend_sp2/data/year_filter_api_caller.dart';
import 'package:frontend_sp2/data/rfc_caller.dart';
import 'package:frontend_sp2/domain/customer_lifetime_value_use_case.dart';
import 'package:frontend_sp2/domain/file_upload_use_case.dart';
import 'package:frontend_sp2/domain/get_companies_use_case.dart';
import 'package:frontend_sp2/domain/get_current_company_use_case.dart';
import 'package:frontend_sp2/domain/get_users_in_company_use_case.dart';
import 'package:frontend_sp2/domain/login_use_case.dart';
import 'package:frontend_sp2/domain/logout_use_case.dart';
import 'package:frontend_sp2/domain/register_user_use_case.dart';
import 'package:frontend_sp2/domain/sales_performance_use_case.dart';
import 'package:frontend_sp2/domain/user_authenticated_use_case.dart';
import 'package:frontend_sp2/domain/user_operations_use_case.dart';
import 'package:frontend_sp2/ui/feature/login/state/login_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/cubit/main_menu_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/state/customer_lifetime_value_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/state/file_upload_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/users/cubit/users_screen_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/add_user_screen/cubit/add_user_screen_cubit.dart';
import 'package:frontend_sp2/ui/feature/menu/users/view/cubit/edit_user_cubit.dart';
import 'package:frontend_sp2/ui/feature/register/state/register_user_cubit.dart';
import 'package:frontend_sp2/ui/feature/select_company/state/select_company_cubit.dart';
import 'package:frontend_sp2/user_operations_caller.dart';
import 'package:frontend_sp2/domain/rfc_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/sales_performance_caller.dart';
import '../../domain/customer_retention_use_case.dart';
import '../../ui/feature/menu/state/customer_retention_cubit.dart';
import '../../ui/feature/menu/state/sales_performance_cubit.dart';
import '../../ui/feature/menu/state/rfc_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeInjectedDependencies() async {
  final environment = DotEnv();
  if (kReleaseMode) {
    await environment.load(fileName: '.env.prod');
  }
  if (kDebugMode) {
    await environment.load(fileName: '.env.dev');
  }
  getIt.registerLazySingleton(() => Logger());
  getIt.registerSingleton(await SharedPreferences.getInstance());
  getIt.registerSingleton(AppRouter());
  getIt.registerSingleton(environment);
  getIt.registerSingleton(setupDio());
  // api callers
  getIt.registerSingleton(BaseApiCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(FileUploadCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(YearFilterApiCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(SalesPerformanceCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(CustomerLifetimeValueCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(CustomerRetentionCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(GetCompaniesCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(GetUsersInCompanyCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(UserOperationsCaller(dio: getIt(), logger: getIt()));
  getIt.registerSingleton(RFCCaller(dio: getIt(), logger: getIt()));
  // use cases
  getIt.registerSingleton(LoginUseCase(getIt()));
  getIt.registerSingleton(GetCurrentCompanyUseCase(getIt()));
  getIt.registerSingleton(RegisterUserUseCase(getIt()));
  getIt.registerSingleton(FileUploadCallerUseCase(getIt()));
  getIt.registerSingleton(LogoutUseCase(getIt()));
  getIt.registerSingleton(UserAuthenticatedUseCase(getIt()));
  getIt.registerSingleton(SalesPerformanceUseCase(getIt(), getIt()));
  getIt.registerSingleton(CustomerLifetimeValueUseCase(getIt(), getIt(), getIt(), getIt()));
  getIt.registerSingleton(CustomerRetentionUseCase(getIt(), getIt(), getIt(), getIt()));
  getIt.registerSingleton(RFCUseCase(getIt(), getIt(), getIt()));
  getIt.registerSingleton(GetCompaniesUseCase(getIt()));
  getIt.registerSingleton(GetUsersInCompanyUseCase(getIt(), getIt()));
  getIt.registerSingleton(UserOperationsUseCase(getIt(), getIt()));
  // blocs factories
  getIt.registerFactory(() => LoginCubit(getIt(), getIt()));
  getIt.registerFactory(() => RegisterUserCubit(getIt()));
  getIt.registerFactory(() => FileUploadCubit(getIt(), getIt()));
  getIt.registerFactory(() => MainMenuCubit(getIt()));
  getIt.registerFactory(() => SalesPerformanceCubit(getIt(), getIt()));
  getIt.registerFactory(() => CustomerLifetimeValueCubit(getIt(), getIt()));
  getIt.registerFactory(() => CustomerRetentionCubit(getIt(), getIt()));
  getIt.registerFactory(() => RFCCubit(getIt(), getIt()));
  getIt.registerFactory(() => SelectCompanyCubit(getIt(), getIt()));
  getIt.registerFactory(() => UsersScreenCubit(getIt(), getIt()));
  getIt.registerFactory(() => EditUserCubit(getIt()));
  getIt.registerFactory(() => AddUserScreenCubit(getIt(), getIt()));
  // guards
  getIt.registerSingleton(MainMenuGuard(getIt()));

}

Dio setupDio() {
  final dio = Dio();
  String url = getIt<DotEnv>().get('BACKEND_URL');
  dio.options.baseUrl = url;
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
