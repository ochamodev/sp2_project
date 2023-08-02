import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sp2/core/app.dart';
import 'package:frontend_sp2/core/di/injector.dart';
import 'package:logger/logger.dart';

void main() async {
  BindingBase.debugZoneErrorsAreFatal = true;
  //WidgetsFlutterBinding.ensureInitialized();
  await initializeInjectedDependencies();
  runZonedGuarded(
          () => runApp(AppSp2()),
        (Object error, StackTrace stackTrace) {
      if (!kReleaseMode) {
        getIt<Logger>().e(error);
      }
    },
  );
}
