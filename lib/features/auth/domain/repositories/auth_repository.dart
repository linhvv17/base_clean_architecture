import 'package:base_clean_architecture/core/core.dart';
import 'package:base_clean_architecture/features/auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login(LoginParams loginParams);
}