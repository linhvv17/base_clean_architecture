import 'package:base_clean_architecture/core/core.dart';
import 'package:base_clean_architecture/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
abstract class AuthRemoteDatasource {
  Future<Either<Failure, AuthResponse>> login(LoginParams loginParams);
}


class AuthRemoteDatasourceImpl implements AuthRemoteDatasource{
  final DioClient dioClient;

  AuthRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, AuthResponse>> login(LoginParams loginParams) async {
    // // TODO: implement login
    // throw UnimplementedError();
    // Get a reference your Supabase client
    final supabase = Supabase.instance.client;

    // final AuthResponse res = await supabase.auth.signInWithPassword(
    //   email: 'example@email.com',
    //   password: 'example-password',
    // );
    // final Session? session = res.session;
    // final User? user = res.user;
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: loginParams.email,
        password: loginParams.password,
      );

      return Right(res);
    } catch (e) {
      return const Left(
        ServerFailure(
          "error"
        ),
      );
    }


  }

}