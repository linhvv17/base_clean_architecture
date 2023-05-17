import 'package:base_clean_architecture/core/error_handling/failures.dart';
import 'package:base_clean_architecture/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:base_clean_architecture/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository{

  //repository impl dependencies data source
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, AuthResponse>> login(LoginParams loginParams) async {
    final response = await authRemoteDatasource.login(loginParams);

    return response.fold(
            (failure) {
              return Left(failure);
            },
            (loginResponse) {
              return Right(loginResponse);
            });
  }

}