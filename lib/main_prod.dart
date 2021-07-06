import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/app.dart';
import 'package:gsy_github_app_flutter/env/config_wrapper.dart';
import 'package:gsy_github_app_flutter/env/env_config.dart';
import 'package:gsy_github_app_flutter/page/error_page.dart';

import 'env/prod.dart';

void main() {
  ///屏幕刷新率和显示率不一致时的优化
  GestureBinding.instance?.resamplingEnabled = true;
  runZonedGuarded(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return ErrorPage(
          details.exception.toString() + "\n " + details.stack.toString(),
          details);
    };
    runApp(ConfigWrapper(
      child: FlutterReduxApp(),
      config: EnvConfig.fromJson(config),
    ));
  }, (Object obj, StackTrace stack) {
    ///do not thing
  });
}
