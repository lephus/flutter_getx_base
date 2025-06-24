import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_getx_base/app/core/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'initGetIt',
  asExtension: false,
)
void configureDependencies() => initGetIt(getIt);
