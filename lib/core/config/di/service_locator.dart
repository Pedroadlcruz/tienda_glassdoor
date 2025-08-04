import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/auth/domain/usecases/login_with_email.dart';
import '../../../features/auth/domain/usecases/login_with_google.dart';
import '../../../features/auth/domain/usecases/logout.dart';
import '../../../features/auth/domain/usecases/register_with_email.dart';
import '../../../features/auth/presentation/blocs/login/login_bloc.dart';
import '../../../features/auth/presentation/blocs/register/register_bloc.dart';
import '../../services/network/network_info.dart';
import '../router/app_router_refresh_notifier.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  // //!Blocs
  sl.registerLazySingleton(
    () => AppRouterRefreshNotifier(sl<AuthRepository>(), sl<NetworkInfo>()),
  );
  sl.registerFactory(
    () => LoginBloc(sl<LoginWithEmail>(), sl<LoginWithGoogle>()),
  );
  sl.registerFactory(
    () => RegisterBloc(sl<RegisterWithEmail>(), sl<LoginWithGoogle>()),
  );

  //! Use cases
  sl.registerLazySingleton(() => LoginWithEmail(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LoginWithGoogle(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterWithEmail(sl<AuthRepository>()));
  sl.registerLazySingleton(() => Logout(sl<AuthRepository>()));

  //! Repositories

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  //!Services

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  //! External Services

  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  /// Dispose all dependencies
  // ignore: unused_element
  Future<void> disposeDependencies() async {
    await sl.reset();
  }
}
