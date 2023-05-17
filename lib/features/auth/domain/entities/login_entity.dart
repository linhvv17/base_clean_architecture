import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_entity.freezed.dart';

// class LoginEntity extends Equatable {
//   final String userName;
//   final String password;
//
//   const LoginEntity({required this.userName, required this.password});
//
//   @override
//   List<Object?> get props => [userName, password];
// }

@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity({String? id}) = _LoginEntity;
}
