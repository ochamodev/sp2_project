import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/app.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:logger/logger.dart';



void main() async {
  BindingBase.debugZoneErrorsAreFatal = false;


  await runZonedGuarded(() async {
    //WidgetsFlutterBinding.ensureInitialized();
    await initializeInjectedDependencies();
    runApp(AppSp2());
  }, (error, stack) {
    if (!kReleaseMode) {
      getIt<Logger>().e(error);
    }
  });
}
