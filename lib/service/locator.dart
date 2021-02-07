import 'package:arika/repository/user_repository.dart';
import 'package:arika/service/auth_service.dart';
import 'package:arika/service/data_service.dart';
import 'package:arika/service/storage_service.dart';
import 'package:arika/service/user_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => DataService());
}
