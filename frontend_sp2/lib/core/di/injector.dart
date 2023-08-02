
import 'package:frontend_sp2/core/navigation/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

Future<void> initializeInjectedDependencies() async {

  getIt.registerLazySingleton(() => Logger());
  getIt.registerSingleton(AppRouter());

}