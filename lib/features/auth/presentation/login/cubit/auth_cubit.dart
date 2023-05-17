import 'package:base_clean_architecture/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/error_handling/failures.dart';

part 'auth_cubit.freezed.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._loginUseCase) : super(const _Loading());

  //presentation communicate with domain by use case
  final LoginUseCase _loginUseCase;

  //login
  Future<void> login(LoginParams params) async {
    //init
    emit(const _Loading());
    // excute
    final data = await _loginUseCase.execute(params);

    data.fold(
            (l) {
              // if (l is ServerFailure) {
              //   emit(_Failure(l.message ?? ""));
              // }
            },
            (r) {
              emit(_Success(r.user?.email.toString()));
            }
    );

    // emit(_Success("data"));
  }

  //logout
  Future<void> logout() async {
    emit(const _Loading());
    // sl<PrefManager>().logout();
    emit(const _Success(null));
  }
}
