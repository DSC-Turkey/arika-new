import 'package:arika/repository/user_repository.dart';
import 'package:arika/services/auth_service.dart';
import 'package:arika/services/user_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => UserService());
}
