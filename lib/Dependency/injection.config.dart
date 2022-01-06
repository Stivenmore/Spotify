import 'package:get_it/get_it.dart';
import 'package:spotify/Data/AuthRespository.dart';
import 'package:spotify/Data/SpotifyRepository.dart';
import 'package:spotify/Domain/Logic/Autenticate/AbstratAutenticate.dart';
import 'package:spotify/Domain/Logic/Spotify/AbstractProvider.dart';
import 'package:spotify/Domain/Bloc/AutenticateBloc.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';

final getIt = GetIt.instance;
void $initGetIt({required String environment}) {
  getIt
    ..registerFactory<AuthReposotory>(() => AuthReposotory())
    ..registerFactory<SpotifyRepository>(() => SpotifyRepository())
    ..registerFactory<AuntenticateBloc>(
        () => AuntenticateBloc(getIt<AbstractAutenticate>()))
    ..registerFactory<SpotifyProvider>(
        () => SpotifyProvider(getIt<AbstractProvider>()));

  if (environment == 'dev') {
    _registerDevDependencies();
  }
}

void _registerDevDependencies() {
  getIt.registerFactory<AbstractAutenticate>(() => AuthReposotory());
  getIt.registerFactory<AbstractProvider>(() => SpotifyRepository());
}
