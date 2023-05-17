import 'package:base_clean_architecture/core/configs/app_configs.dart';
import 'package:base_clean_architecture/core/core.dart';
import 'package:base_clean_architecture/features/features.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt getIt = GetIt.instance;

// register dependencies injection
Future<void> serviceLocator() async {
  getIt.registerSingleton<DioClient>(DioClient());
  dataSource();
  repositories();
  useCase();
  cubit();

  ///
  ///
  ///

}

void cubit() {
  /// Auth
  getIt.registerLazySingleton(() => AuthCubit(getIt()));
}

void useCase() {
  /// Auth
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
}
/// Register repositories
void repositories() {
  /// Auth
  getIt.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(authRemoteDatasource: getIt())
  );
}
/// Register dataSources
void dataSource() {
  /// Auth
  getIt.registerLazySingleton<AuthRemoteDatasource>(
          () => AuthRemoteDatasourceImpl(dioClient: getIt())
  );
}