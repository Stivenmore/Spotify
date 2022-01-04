

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/Dependency/injection.config.dart';

GetIt getIt = GetIt.instance;  
@injectableInit
void configureInjection(String? environment) => 
     $initGetIt(environment: environment!);

abstract class Env {
  static const dev  = 'dev' ;
  static const prod = 'prod';
}