import 'package:auto_route/auto_route.dart';
import 'package:base_clean_architecture/core/core.dart';
import 'package:base_clean_architecture/features/auth/presentation/home/home_screen.dart';
import 'package:base_clean_architecture/features/features.dart';
import 'package:base_clean_architecture/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Controller
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  bool _isPasswordHide = true;

  /// Global key
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (_, state) {
          state.when(
            loading: () => context.show(),
            success: (data) {
              print("aaaaaaaaaaaaaaaaaaaaaaaaaa");
              print(data);
              // context.dismiss();
              // data.toString().toToastSuccess();
              // TextInput.finishAutofillContext();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => HomePage(data: data!,)
                )
              );

            },
            failure: (message) {
              context.dismiss();
              message.toToastError();
            },
          );
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: AutofillGroup(
                child: Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Palette.primary,
                        radius: Dimens.profilePicture + Dimens.space4,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(Images.icLauncher),
                          radius: Dimens.profilePicture,
                        ),
                      ),
                      const SpacerV(),
                      TextF(
                        autofillHints: const [AutofillHints.email],
                        key: const Key("email"),
                        curFocusNode: _fnEmail,
                        nextFocusNode: _fnPassword,
                        textInputAction: TextInputAction.next,
                        controller: _conEmail,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        hintText: "eve.holt@reqres.in",
                        hint: Strings.of(context)!.email,
                        validator: (String? value) => value != null
                            ? (!value.isValidEmail()
                            ? Strings.of(context)?.errorInvalidEmail
                            : null)
                            : null,
                      ),
                      TextF(
                        autofillHints: const [AutofillHints.password],
                        key: const Key("password"),
                        curFocusNode: _fnPassword,
                        textInputAction: TextInputAction.done,
                        controller: _conPassword,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        obscureText: _isPasswordHide,
                        hintText: '••••••••••••',
                        maxLine: 1,
                        hint: Strings.of(context)!.password,
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(
                                  () {
                                _isPasswordHide = !_isPasswordHide;
                              },
                            );
                          },
                          icon: Icon(
                            _isPasswordHide
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: (String? value) => value != null
                            ? (value.length < 3
                            ? Strings.of(context)!.errorEmptyField
                            : null)
                            : null,
                      ),
                      SpacerV(value: Dimens.space24),
                      Button(
                        title: Strings.of(context)!.login,
                        onPressed: () {
                          if (_keyForm.currentState?.validate() ?? false) {
                            context.read<AuthCubit>().login(
                              LoginParams(
                                email: _conEmail.text,
                                password: _conPassword.text,
                              ),
                            );
                          }
                        },
                      ),
                      ButtonText(
                        title: Strings.of(context)!.askRegister,
                        onPressed: () {
                          /// Direct to register page
                          // context.pushNamed(Routes.register.name);

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}