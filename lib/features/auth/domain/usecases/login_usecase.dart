import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:base_clean_architecture/core/core.dart';
import 'package:base_clean_architecture/features/features.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_usecase.freezed.dart';
part 'login_usecase.g.dart';


class LoginUseCase extends BaseUseCase<AuthResponse, LoginParams>{
  final AuthRepository _loginRepository;

  LoginUseCase(this._loginRepository);


  @override
  Future<Either<Failure, AuthResponse>> execute(LoginParams params) =>
      _loginRepository.login(params);
}

@freezed
class LoginParams with _$LoginParams {
  const factory LoginParams({
    @Default("") String email,
    @Default("") String password,
  }) = _LoginParams;

  factory LoginParams.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsFromJson(json);
}